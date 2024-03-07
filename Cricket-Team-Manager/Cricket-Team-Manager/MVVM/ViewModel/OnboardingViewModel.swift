//
//  OnboardingViewModel.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation
import FirebaseAuth
import SwiftUI

final class OnboardingViewModel: ObservableObject {
        
    @Published var userState: LoginState = Auth.auth().currentUser == nil ? .login : .home
    
    @Published var isLoading = false
    
    @Published var errorMessage = ""
    @Published var showError = false
    
    // only used when signing up
    @Published var user = AppUser()
    
    init() {
        //self.addAuthenticationListener()
    }
    /*
    private func addAuthenticationListener() {
        Auth.auth().addStateDidChangeListener { auth, user in
            
            guard let _ = Auth.auth().currentUser else {
                self.userState = .login
                return
            }
            
            self.userState = .home
            
        }
    }
     */
    
    func loginUser(email: String, password: String) {
        
        guard !email.isEmpty else {
            self.present(error: "Please Enter Email")
            return
        }
        
        guard email.isValidEmail() else {
            self.present(error: "Email is not valid, Please Enter Correct Email Address")
            return
        }
        
        guard !password.isEmpty else {
            self.present(error: "Password can not be empty")
            return
        }
            
        self.isLoading = true
            
        Task { @MainActor in
            do {
                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
                
                let user = try await FirestoreManager.shared.fetchUser(userID: authResult.user.uid)
                
                self.isLoading = false
                
                // 1. Show Home if Profile is Completed else show Create Profile View
                withAnimation {
                    self.userState = user.isProfileCompleted ? .home : .newUser
                }
            }
            catch {
                self.isLoading = false
                self.present(error: "Login Error: \(error.localizedDescription)")
            }
        }
    }
    
    func signUpUser(email: String, password: String, firstName: String, lastName: String, selectedImage: UIImage? = nil) {
        
        guard !email.isEmpty else {
            self.present(error: "Please Enter Email")
            return
        }
        
        guard email.isValidEmail() else {
            self.present(error: "Email is not valid, Please Enter Correct Email Address")
            return
        }
        
        guard !password.isEmpty else {
            self.present(error: "Password can not be empty")
            return
        }
        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                
                // 1. Authenticate
                try await Auth.auth().createUser(withEmail: email, password: password)
                
                // 2. Create Database
                user.email = email
                FirestoreManager.shared.updateUser(user: user)
                
                // 3. Hide Loader
                self.isLoading = false
                
                // 4. Go to Create Account
                withAnimation {
                    self.userState = .newUser
                }
            }
            catch {
                self.present(error: error.localizedDescription)
                self.isLoading = false
            }
        }
    }
    
    func createAccount(selectedImage: UIImage?) {
        
        guard !user.firstName.isEmpty else {
            self.present(error: "First Name can not be empty")
            return
        }
        
        guard !user.lastName.isEmpty else {
            self.present(error: "Last Name can not be empty")
            return
        }
        
        guard !user.country.isEmpty else {
            self.present(error: "Country can not be empty")
            return
        }
        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                // 2. Upload Picture
                var downloadURL: String? = nil
                if let image = selectedImage {
                    downloadURL = try await StorageManager.shared.uploadImage(image: image).absoluteString
                }
                
                user.imageURL = downloadURL
                
                FirestoreManager.shared.updateUser(user: user)
                self.isLoading = false
                withAnimation {
                    self.userState = .home
                }
            }
            catch {
                self.isLoading = false
                self.present(error: error.localizedDescription)
            }
        }

    }
    
    func forgotPassword(email: String) {
        
        guard !email.isEmpty else {
            self.present(error: "Please Enter Email")
            return
        }
        
        guard email.isValidEmail() else {
            self.present(error: "Email is not valid, Please Enter Correct Email Address")
            return
        }
        
        self.isLoading = true

        Task { @MainActor in
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
            }
            catch {
                self.isLoading = false
                self.present(error: "Login Error: \(error.localizedDescription)")
            }
        }
    }
    
    func present(error: String) {
        self.errorMessage = error
        self.showError = true
    }
}
