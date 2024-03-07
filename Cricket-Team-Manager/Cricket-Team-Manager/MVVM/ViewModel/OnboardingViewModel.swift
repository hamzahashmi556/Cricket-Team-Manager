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
        
    @Published var userState: LoginState = .login
    
    @Published var isLoading = false
    
    @Published var errorMessage = ""
    @Published var showError = false
    
    @Published var user = AppUser()
    
    init() {
        self.setupUserState()
    }
    
    func setupUserState() {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.userState = .login
            return
        }
        
        Task { @MainActor in
            do {
                let user = try await FirestoreManager.shared.fetchUser(userID: uid, fromCache: false)
                self.userState = user.isProfileCompleted ? .home : .newUser
            }
            catch {
                print(#function, error)
                self.present(error: error.localizedDescription)
            }
        }
    }
    
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
                
                let user = try await FirestoreManager.shared.fetchUser(userID: authResult.user.uid, fromCache: false)
                
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
    
    func signUpUser(email: String, password: String, selectedImage: UIImage? = nil) {
        
        guard !user.firstName.isEmpty else {
            self.present(error: "Please Enter First Name")
            return
        }

        guard !user.lastName.isEmpty else {
            self.present(error: "Please Enter Last Name")
            return
        }
        
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
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                
                // 2. Upload Image
                if let image = selectedImage {
                    user.imageURL = try await StorageManager.shared.uploadImage(image: image).absoluteString
                }
                
                // 2. Create Database
                user.uid = authResult.user.uid
                user.email = email
                try await FirestoreManager.shared.updateUser(user: user)
                
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
    
    func createAccount() {
        
        guard !user.city.isEmpty else {
            self.present(error: "Please Enter City")
            return
        }
        
        guard !user.country.isEmpty else {
            self.present(error: "Please Enter Country")
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            self.present(error: "Authentication Failed, Please Login Again")
            return
        }
        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                // The App reopened during sign up process, fetch the sign up fields from firestore then update with remaining fields
                if user.firstName.isEmpty && user.lastName.isEmpty && user.email.isEmpty {
                    let existingUser = try await FirestoreManager.shared.fetchUser(userID: uid, fromCache: false)
                    user.imageURL = existingUser.imageURL
                    user.firstName = existingUser.firstName
                    user.lastName = existingUser.lastName
                    user.email = existingUser.email
                }
                
                user.uid = uid
                user.isProfileCompleted = true
                try await FirestoreManager.shared.updateUser(user: user)
                
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
