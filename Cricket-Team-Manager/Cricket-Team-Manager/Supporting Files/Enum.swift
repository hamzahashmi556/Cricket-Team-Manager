//
//  Enum.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation

//enum PropertyType {
//    case homes
//    case plots
//}
//
//enum ServiceType: Codable {
//    case rent
//    case sell
//}
//
//enum City: Codable {
//    case Karachi
//    case Lahore
//    case Islamabad
//}
//
enum LoginState {
    case login
    case newUser
    case home
}

enum Gender: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
}

enum CricketerType: String, Codable, CaseIterable {
    case none = "Select Your Type"
    case allRounder = "All Rounder"
    case batsman = "Batsman"
    case bowler = "Bowler"
    case wicketKeeper = "Wicket Keeper"
    
    func text(gender: Gender) -> String {
        switch self {
        case .none:
            return "Select Your Type"
        case .allRounder:
            return "All Rounder"
        case .batsman:
            return gender == .male ? self.rawValue : "Batswoman"
        case .bowler:
            return self.rawValue
        case .wicketKeeper:
            return self.rawValue
        }
    }
}

enum BatsmanType: String, Codable, CaseIterable {
    case none = "Select Your Type"
    case left = "Left-Arm Batsman"
    case righ = "Right-Arm Batsman"
}

enum BowlerType: String, Codable, CaseIterable {
    case none = "Select Your Type"
    case rightFast = "Right-Arm Fast Bowler"
    case leftFast = "Left-Arm Fast Bowler"
    case rightMedium = "Right-Arm Medium Fast Bowler"
    case leftMedium = "Left-Arm Medium Fast Bowler"
    case legSpinner = "Leg Spinner"
    case offSpinner = "Off Spinner"
}

enum TeamType: Codable {
    case none
    case international
    case domestic
}
