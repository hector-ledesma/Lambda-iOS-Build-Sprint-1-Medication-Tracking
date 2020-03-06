//
//  StatusModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

enum Status: String, Codable {
    
    case standby
    case done
    case cancelled
    case skipped
    
}
