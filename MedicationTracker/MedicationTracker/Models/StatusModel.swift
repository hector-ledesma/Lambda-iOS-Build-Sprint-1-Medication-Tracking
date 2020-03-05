//
//  StatusModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

enum Status: Codable {
    init(from decoder: Decoder) throws {
        <#code#>
    }
    
    func encode(to encoder: Encoder) throws {
        <#code#>
    }
    
    case standby
    case done
    case cancelled
    case skipped
}
