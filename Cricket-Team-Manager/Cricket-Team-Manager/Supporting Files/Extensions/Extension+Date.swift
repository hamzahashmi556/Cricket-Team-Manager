//
//  Extension+Date.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 08/03/2024.
//

import Foundation

extension Date {
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var experienceInYears: Int {
        return Calendar.current.dateComponents([.year], from: self, to: .now).year!
    }
    
    func format(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
