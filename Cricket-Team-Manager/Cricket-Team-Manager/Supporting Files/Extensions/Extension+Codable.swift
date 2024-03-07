//
//  Extension+Codable.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 08/03/2024.
//

import Foundation

extension Encodable {
    
    func toDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let jsonData = try encoder.encode(self)

        guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            throw NSError(domain: "ConversionError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert JSON data to dictionary."])
        }

        return jsonObject
    }
}
