//
//  User.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation

struct AppUser: Codable, Identifiable {
    
    var id: String {
        return uid
    }
    
    var uid: String = ""
    
    // Basic Sign Up
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var imageURL: String? = nil

    // Bio
    var gender = Gender.male
    var city: String = ""
    var country : String = ""
    var dateOfBirth: Date = .now
    
    // Career/Skills
    var type: CricketerType = .none
    var batsman : BatsmanType = .none
    var bowler: BowlerType = .none

    var intCareerStart: Date = .now
    var intCareerEnd: Date = .now
    
    // Joined Team
    var joinedTeamIDs: [String] = []
    var isProfileCompleted = false
}
