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
    
    private let usersRef = Firestore.firestore().collection("users")
    
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
}
