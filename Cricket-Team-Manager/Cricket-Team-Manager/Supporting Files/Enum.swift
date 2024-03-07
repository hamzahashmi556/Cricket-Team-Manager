//
//  Enum.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation

enum PropertyType {
    case homes
    case plots
}

enum ServiceType: Codable {
    case rent
    case sell
}

enum City: Codable {
    case Karachi
    case Lahore
    case Islamabad
}

enum LoginState {
    case login
    case newUser
    case home
}
