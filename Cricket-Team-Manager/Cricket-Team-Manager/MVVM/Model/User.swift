//
//  User.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation

struct AppUser: Codable {
    
    var firstName: String = ""
    var lastName: String = ""
    var city: String = ""
    var country : String = ""
    var dateOfBirth: Date = .now
    
    var email: String = ""
    var imageURL: String? = nil
    
    
    
    var type: CricketerType = .none
    var intCareerStart: Date = .now
    var intTeamID: String = ""
    var domesticTeamIDs: [String] = []
}

struct Team: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    var teamID: String
    var name: String
    var imageName: String
    var type: TeamType
}
