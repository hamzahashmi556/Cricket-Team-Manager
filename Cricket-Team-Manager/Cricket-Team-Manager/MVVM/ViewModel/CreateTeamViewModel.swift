//
//  CreateTeamViewModel.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 08/03/2024.
//

import Foundation
import SwiftUI

class CreateTeamViewModel: ObservableObject {
    
    @Published var selectedImage: UIImage? = nil
    @Published var name = ""
    
    @Published var selectedPlayers: [AppUser] = []

    
    @Published var numberOfBowlers = 4
    @Published var numberOfBatsman = 5
    @Published var numberOfAllRounders = 2
    
    @Published var isLoading = false
    @Published var showError = false
    @Published var error = ""

    var limitExceeded: Bool {
        return numberOfBatsman + numberOfBowlers + numberOfAllRounders > 11
    }
    
    func selectPlayer(for selection: CricketerType, user: AppUser) {
                
        if let index = selectedPlayers.firstIndex(where: { $0.uid == user.uid }) {
            selectedPlayers.remove(at: index)
        }
        else {
            if selection == .allRounder {
                let selectedAllRounders = self.selectedPlayers.filter({ $0.type == .allRounder })
                guard selectedAllRounders.count < numberOfAllRounders else {
                    error = "All Rounders Limit Exceeded"
                    showError = true
                    return
                }
            }
            else if selection == .batsman {
                let selectedBatsman = self.selectedPlayers.filter({ $0.type == .batsman })
                guard selectedBatsman.count < numberOfBatsman else {
                    error = "Batsman Limit Exceeded"
                    showError = true
                    return
                }
            }
            else if selection == .bowler {
                let selectedBowlers = self.selectedPlayers.filter({ $0.type == .bowler })
                guard selectedBowlers.count < numberOfBowlers else {
                    error = "Bowlers Limit Exceeded"
                    showError = true
                    return
                }
            }
            selectedPlayers.append(user)
        }
    }
    
    func createTeam() {
        
        guard isLoading == false else {
            return
        }
        
        print(#function)
        
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
        
        guard selectedPlayers.count == 11 else {
            self.error = "The Selected Player are greater or Less Than 11"
            self.showError = true
            return
        }

        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                // 1. Upload Image
                let imageURL = try await StorageManager.shared.uploadImage(image: selectedImage, filename: UUID().uuidString).absoluteString
                
                try await FirestoreManager.shared.createTeam(name: name, imageURL: imageURL, players: selectedPlayers)
                
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
