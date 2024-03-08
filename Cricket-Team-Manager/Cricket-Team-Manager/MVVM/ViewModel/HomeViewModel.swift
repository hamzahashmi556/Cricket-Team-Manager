//
//  HomeViewModel.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import Foundation
import FirebaseAuth
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    
    @Published var users: [AppUser] = []
    @Published var userProfile = AppUser()
    
    @Published var teams: [Team] = []
    
    @Published var league: [League] = []

    
    @Published var isLoading = false
    @Published var isPresentAlert = false
    @Published var alertMessage = ""
    
    init() {
        self.fetchUsers()
        self.fetchTeams()
        self.fetchLeagues()
    }
    
    func fetchUsers() {
        
//        guard let uid = Auth.auth().currentUser?.uid else {
//            self.show(error: "Session Expired, Login Again")
//            return
//        }
        
        FirestoreManager.shared.fetchAllUsers { users in
            if let uid = Auth.auth().currentUser?.uid,
               let userProfile = users.first(where: { $0.uid == uid }) {
                self.userProfile = userProfile
            }
            self.users = users
        } failure: { error in
            self.show(error: error.localizedDescription)
        }
    }
    
    func fetchTeams() {
        FirestoreManager.shared.fetchAllTeams(success: { teams in
            self.teams = teams
        }, failure: { error in
            self.show(error: error.localizedDescription)
        })
    }
    
    func fetchLeagues() {
        FirestoreManager.shared.fetchAllLeagues(success: { teams in
            self.league = teams
        }, failure: { error in
            self.show(error: error.localizedDescription)
        })
    }
    
    func update(user: AppUser, selectedImage: UIImage?) {
        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                var user = user
                // 1. Upload Selected Image First
                if let selectedImage {
                    let imageURL = try await StorageManager.shared.uploadImage(image: selectedImage, filename: UUID().uuidString)
                    user.imageURL = imageURL.absoluteString
                }
                try await FirestoreManager.shared.updateUser(user: user)
                self.isLoading = false
                NotificationCenter.default.post(name: .closeEditProfile, object: nil)
            }
            catch {
                self.show(error: error.localizedDescription)
            }
        }
    }
    
    private func show(error: String) {
        self.isLoading = false
        self.isPresentAlert = true
        self.alertMessage = error
    }
}
