//
//  AlertModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class Alert: Equatable {
    
    
    var identifier: Identifier
    var isActive: Bool
    
    init(item: Identifier) {
        self.identifier = item
        self.isActive = true
        
        createAlerts()
    }
    
    func createAlerts() {
        
    }
    
    static func == (lhs: Alert, rhs: Alert) -> Bool {
        return lhs.identifier.name == rhs.identifier.name && lhs.isActive == rhs.isActive
    }
}
