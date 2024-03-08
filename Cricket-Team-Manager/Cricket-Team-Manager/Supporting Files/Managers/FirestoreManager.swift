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
    
    private let leaguesRef = Firestore.firestore().collection("Leagues")
    
    private init() {}
    
    var cachedUsers: [AppUser] = []
    
    func updateUser(user: AppUser) async throws -> Void {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        return try await withUnsafeThrowingContinuation { continuation in
            do {
                try usersRef.document(uid).setData(from: user) { error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    }
                    else {
                        continuation.resume()
                    }
                }
            }
            catch {
                print(#function)
                print("Decoding Error user: \(error)")
            }
        }
    }
    
    func fetchUser(userID: String, fromCache isCacheEnabled : Bool) async throws -> AppUser {
        
        if isCacheEnabled, let cacheUser = self.cachedUsers.first(where: { $0.uid == userID }) {
            return cacheUser
        }
        let document = try await usersRef.document(userID).getDocument()
        
        let user = try document.data(as: AppUser.self)
        
        self.updateCache(user: user)
        
        return user
    }
    
    func fetchAllUsers(success: @escaping ([AppUser]) -> Void, failure: @escaping (Error) -> Void) {
        
        usersRef.addSnapshotListener { snapshot, error in
            if let error = error {
                failure(error)
            }
            else if let documents = snapshot?.documents {
                var users: [AppUser] = []
                
                for doc in documents {
                    do {
                        let user = try doc.data(as: AppUser.self)
                        users.append(user)
                    }
                    catch {
                        print(#function, error)
                    }
                }
                
                self.cachedUsers = users
                success(users)
            }
        }
    }
    
    func fetchAllTeams(success: @escaping ([Team]) -> Void, failure: @escaping (Error) -> Void) {
        
        teamsRef.addSnapshotListener { snapshot, error in
            if let error = error {
                failure(error)
            }
            else if let documents = snapshot?.documents {
                var teams: [Team] = []
                
                for doc in documents {
                    do {
                        let team = try doc.data(as: Team.self)
                        teams.append(team)
                    }
                    catch {
                        print(#function, error)
                    }
                }
                
                success(teams)
            }
        }
    }
    
    func fetchAllLeagues(success: @escaping ([League]) -> Void, failure: @escaping (Error) -> Void) {
        
        leaguesRef.addSnapshotListener { snapshot, error in
            if let error = error {
                failure(error)
            }
            else if let documents = snapshot?.documents {
                var leagues: [League] = []
                
                for doc in documents {
                    do {
                        let league = try doc.data(as: League.self)
                        leagues.append(league)
                    }
                    catch {
                        print(#function, error)
                    }
                }
                
                success(leagues)
            }
        }
    }
    
    func createTeam(name: String, imageURL: String, players: [AppUser]) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        var players = players
        
        var team = Team(uid: uid, name: name, imageURL: imageURL)
        
        let batch = Firestore.firestore().batch()
        
        for i in 0 ..< players.count {
            let docRef = usersRef.document(players[i].uid)
            
            players[i].joinedTeamIDs.append(team.id)
            
            try batch.setData(from: players[i], forDocument: docRef)
        }
        
        team.playerIDs = players.map({ $0.uid })
        
        try batch.setData(from: team, forDocument: teamsRef.document(team.id))
        
        try await batch.commit()
    }
    
    func updateCache(user: AppUser) {
        if !self.cachedUsers.contains(where: { $0.uid == user.uid }) {
            self.cachedUsers.append(user)
        }
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
