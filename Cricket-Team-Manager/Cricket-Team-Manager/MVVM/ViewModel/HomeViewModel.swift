//
//  HomeViewModel.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import Foundation
import FirebaseAuth

final class HomeViewModel: ObservableObject {
    
    var userProfile = AppUser()
    
    @Published var isPresentAlert = false
    @Published var alertMessage = ""
    
    init() {
        self.fetchUser()
    }
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            self.show(error: "Session Expired, Login Again")
            return
        }
        
        Task { @MainActor in
            do {
                self.userProfile = try await FirestoreManager.shared.fetchUser(userID: uid)
            }
            catch {
                self.show(error: error.localizedDescription)
            }
        }
    }
    
    private func show(error: String) {
        self.isPresentAlert = true
        self.alertMessage = error
    }
}
