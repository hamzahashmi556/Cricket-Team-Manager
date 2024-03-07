//
//  Cricket_Team_ManagerApp.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import SwiftUI
import Firebase

@main
struct Cricket_Team_ManagerApp: App {
    
    init() {
        FirebaseApp.configure()
//        FirestoreManager.shared.addTeamsToFirestore()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
