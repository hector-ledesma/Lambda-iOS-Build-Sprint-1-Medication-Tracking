//
//  StatusModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

enum Status: Codable {
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            self = .standby
        case 1:
            self = .done
        case 2:
            self = .cancelled
        case 3:
            self = .skipped
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .standby:
            try container.encode(0, forKey: .rawValue)
        case .done:
            try container.encode(1, forKey: .rawValue)
        case .cancelled:
            try container.encode(2, forKey: .rawValue)
        case .skipped:
            try container.encode(3, forKey: .rawValue)
            
        }
    }
    
    case standby
    case done
    case cancelled
    case skipped
}
