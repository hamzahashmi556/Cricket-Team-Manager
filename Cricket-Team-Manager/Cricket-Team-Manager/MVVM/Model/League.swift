//
//  League.swift
//  Cricket-Team-Manager
//
//  Created by Rehana Syed on 08/03/2024.
//

import Foundation

struct League: Codable, Identifiable, Hashable {
    
    var id = UUID().uuidString
    var uid: String
    var name: String = ""
    var imageURL: String = ""
    var playerIDs: [String] = []
}
