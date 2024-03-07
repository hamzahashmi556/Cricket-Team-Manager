//
//  FirestoreManager.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 03/03/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    private let usersRef = Firestore.firestore().collection("Users")
    
    private let teamsRef = Firestore.firestore().collection("Teams")
    
    private init() {}
    
    func updateUser(user: AppUser) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        do {
            try usersRef.document(uid).setData(from: user)
        }
        catch {
            print(#function)
            print("Decoding Error user: \(error)")
        }
    }
    
    func fetchUser(userID: String) async throws -> AppUser {
        let document = try await usersRef.document(userID).getDocument()
        let user = try document.data(as: AppUser.self)
        return user
    }
    /*
    func addTeamsToFirestore() {
        
        let internationTeams: [Team] = [
            .init(teamID: "Int-IND", name: "INDIA", imageName: "🇮🇳", type: .international),
            .init(teamID: "Int-AUS", name: "AUSTRALIA", imageName: "🇦🇺", type: .international),
            .init(teamID: "Int-SA", name: "SOUTH AFRICA", imageName: "🇿🇦", type: .international),
            .init(teamID: "Int-PAK", name: "PAKISTAN", imageName: "🇵🇰", type: .international),
            .init(teamID: "Int-NZ", name: "NEW ZEALAND", imageName: "🇳🇿", type: .international),
            .init(teamID: "Int-ENG", name: "ENGLAND", imageName: "🏴󠁧󠁢󠁥󠁮󠁧󠁿", type: .international),
            .init(teamID: "Int-SL", name: "SRI LANKA", imageName: "🇱🇰", type: .international),
            .init(teamID: "Int-BAN", name: "BANGLADESH", imageName: "🇧🇩", type: .international),
            .init(teamID: "Int-AFG", name: "AFGHANISTAN", imageName: "🇦🇫", type: .international),
            .init(teamID: "Int-IRE", name: "IRELAND", imageName: "🇮🇪", type: .international),
        ]
        
        Task {
            do {
                let batch = Firestore.firestore().batch()
                for team in internationTeams {
                    let docRef = teamsRef.document(team.id)
                    try batch.setData(from: team, forDocument: docRef)
                }
                try await batch.commit()
            }
            catch {
                print("Error Adding Teams: \(error.localizedDescription)")
            }
        }
    }
     */
}
