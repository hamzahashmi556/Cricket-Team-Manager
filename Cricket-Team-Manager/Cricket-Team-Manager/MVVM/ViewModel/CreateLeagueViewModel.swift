//
//  CreateLeagueViewModel.swift
//  Cricket-Team-Manager
//
//  Created by Rehana Syed on 08/03/2024.
//

import Foundation
import SwiftUI

class CreateLeagueViewModel: ObservableObject {
    

    @Published var selectedImage: UIImage? = nil
    @Published var name = ""
    
    @Published var selectedTeams: [String] = []
    
    @Published var isLoading = false
    @Published var showError = false
    @Published var error = ""

    
    func createTeam(creatorID: String) {
        
        guard let selectedImage else {
            self.error = "Select Team Image"
            self.showError = true
            return
        }
        
        
        guard !name.isEmpty else {
            self.error = "Enter Team Name"
            self.showError = true
            return
        }
        
        guard selectedTeams.count > 2 else {
            self.showError = true
            self.error = "Must Be Atleast 3 Teams To Select"
            return
        }
        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                // 1. Upload Image
                let imageURL = try await StorageManager.shared.uploadImage(image: selectedImage, filename: UUID().uuidString).absoluteString
                
                try await FirestoreManager.shared.createLeague(name: name, imageURL: imageURL, teamIDs: selectedTeams, creatorID: creatorID)
                
                NotificationCenter.default.post(name: .closeCreateTeamView, object: nil)
            }
            catch {
                self.error = error.localizedDescription
                self.showError = true
                self.isLoading = false
            }
        }
    }
}
