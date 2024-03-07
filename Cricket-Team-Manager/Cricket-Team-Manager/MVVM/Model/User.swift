//
//  User.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation

struct AppUser: Codable {
    
    var email: String
    var imageURL: String
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var country : String
    var type: CricketerType
    var intCareerStart: Date
    var intTeam: Team
    var domesticTeams: [Team]
}

struct Team: Codable {
    var name: String
    var imageName: String
    var type: TeamType
}
