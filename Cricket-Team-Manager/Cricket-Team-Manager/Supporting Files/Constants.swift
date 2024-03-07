//
//  Constants.swift
//  Cricket-Team-Manager
//
//  Created by Rehana Syed on 07/03/2024.
//

import Foundation

struct Constants {
    
    static let internationTeams: [Team] = [
        .init(teamID: "Int-IND", name: "INDIA", imageName: ":flag-in:", type: .international),
        .init(teamID: "Int-AUS", name: "AUSTRALIA", imageName: ":flag-au:", type: .international),
        .init(teamID: "Int-SA", name: "SOUTH AFRICA", imageName: ":flag-za:", type: .international),
        .init(teamID: "Int-PAK", name: "PAKISTAN", imageName: ":flag-pk:", type: .international),
        .init(teamID: "Int-NZ", name: "NEW ZEALAND", imageName: ":flag-nz:", type: .international),
        .init(teamID: "Int-ENG", name: "ENGLAND", imageName: ":flag-england:", type: .international),
        .init(teamID: "Int-SL", name: "SRI LANKA", imageName: ":flag-lk:", type: .international),
        .init(teamID: "Int-BAN", name: "BANGLADESH", imageName: ":flag-bd:", type: .international),
        .init(teamID: "Int-AFG", name: "AFGHANISTAN", imageName: ":flag-af:", type: .international),
        .init(teamID: "Int-IRE", name: "IRELAND", imageName: ":flag-ie:", type: .international),
      ]
    
    static let domesticTeams: [Team] = [
        .init(teamID: "PSL-KK", name: "Karachi Kings", imageName: "", type: .domestic),
        .init(teamID: "PSL-LQ", name: "Lahore Qalandars", imageName: "", type: .domestic),
        .init(teamID: "PSL-QG", name: "Quetta Gladiators", imageName: "", type: .domestic),
        .init(teamID: "PSL-PZ", name: "Peshawar Zalmi", imageName: "", type: .domestic),
        .init(teamID: "PSL-MS", name: "Multan Sultans", imageName: "", type: .domestic),
        .init(teamID: "PSL-IU", name: "Islamabad United", imageName: "", type: .domestic)
    ]
}
