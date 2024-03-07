//
//  Team.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation

struct Team: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    var teamID: String
    var name: String
    var imageName: String
    var type: TeamType
    var playerIDs: [String] = []
}
