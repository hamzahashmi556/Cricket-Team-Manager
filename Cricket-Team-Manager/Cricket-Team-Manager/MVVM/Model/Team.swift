//
//  Team.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation

struct Team: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    var uid: String
    var name: String = ""
    var imageURL: String = ""
    var playerIDs: [String] = []
}
