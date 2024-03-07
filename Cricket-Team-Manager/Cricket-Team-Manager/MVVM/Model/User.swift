//
//  User.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation

struct AppUser: Codable {
    
    // Basic Sign Up
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var imageURL: String? = nil

    // Bio
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
    var intTeamID: String = ""
    var domesticTeamIDs: [String] = []
    
    var isProfileCompleted = false
}

struct Team: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    var teamID: String
    var name: String
    var imageName: String
    var type: TeamType
}
