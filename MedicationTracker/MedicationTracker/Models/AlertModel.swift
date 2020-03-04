//
//  AlertModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class Alert {
    var identifier: Identifier
    var isActive: Bool
    
    init(item: Identifier) {
        self.identifier = item
        self.isActive = true
    }
    
    func createAlerts() {
        
    }
}
