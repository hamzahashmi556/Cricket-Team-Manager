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
    
    @Published var isPresentLogin = false
    @Published var isPresentCreateUser = false
    @Published var isPresentCreatTeam = false
    @Published var isPresentSelectSignup = false
    
    
    @Published var errorMessage = ""
    @Published var showError = false
    
    init() {
//        self.addAuthenticationListener()
    }
    
    private func addAuthenticationListener() {
        Auth.auth().addStateDidChangeListener { auth, user in
            
            guard let _ = Auth.auth().currentUser else {
                self.userState = .login
                return
            }
            
            self.userState = .home
            
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
                try await Auth.auth().signIn(withEmail: email, password: password)
                self.isLoading = false
            }
            catch {
                self.isLoading = false
                self.present(error: "Login Error: \(error.localizedDescription)")
            }
        }
    }
    
    func signUpUser(email: String, password: String, firstName: String, lastName: String, selectedImage: UIImage?, dateOfBirth: Date, internationalTeamID: String, type: CricketerType, domesticTeams: [String] = [], country: String, careerStartDate: Date) {
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
        
        guard !firstName.isEmpty else {
            self.present(error: "First Name can not be empty")
            return
        }
        
        guard !lastName.isEmpty else {
            self.present(error: "Last Name can not be empty")
            return
        }
        
        guard !country.isEmpty else {
            self.present(error: "Country can not be empty")
            return
        }
        
        self.isLoading = true
        
        Task {
            do {
                // 1. Authenticate
                try await Auth.auth().createUser(withEmail: email, password: password)
                
                // 2. Upload Picture
                var downloadURL: String? = nil
                if let image = selectedImage {
                    downloadURL = try await StorageManager.shared.uploadImage(image: image).absoluteString
                }
                
                // 3. Create Database
//                let user = AppUser(email: email, firstName: firstName, lastName: lastName, imageURL: downloadURL)
                let user = AppUser(email: email, imageURL: downloadURL, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, country: country, type: type, intCareerStart: careerStartDate, intTeamID: internationalTeamID, domesticTeamIDs: domesticTeams)
                
                FirestoreManager.shared.updateUser(user: user)
                
                self.isLoading = false
            }
            catch {
                self.present(error: error.localizedDescription)
                self.isLoading = false
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
