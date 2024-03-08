//
//  HomeViewModel.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import Foundation
import FirebaseAuth

final class HomeViewModel: ObservableObject {
    
    
    @Published var users: [AppUser] = []
    @Published var userProfile = AppUser()
    
    @Published var teams: [Team] = []
    
    @Published var isLoading = false
    @Published var isPresentAlert = false
    @Published var alertMessage = ""
    
    init() {
        self.fetchUsers()
        self.fetchTeams()
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
    
    private func show(error: String) {
        self.isPresentAlert = true
        self.alertMessage = error
    }
}
