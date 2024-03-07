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

enum CricketerType: String, Codable, CaseIterable {
    case none
    case allRounder
    case batsman
    case bowler
    case wicketKeeper
}

enum BatsmanType: String, Codable, CaseIterable {
    case none
    case left = "Left-Arm Batsman"
    case righ = "Right-Arm Batsman"
}

enum BowlerType: String, Codable, CaseIterable {
    case none
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
