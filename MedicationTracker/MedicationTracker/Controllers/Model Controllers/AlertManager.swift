//
//  AlertManager.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class AlertManager {
    var alerts: [Alert] = []
    var activeAlerts: [Alert] {
        get {
            let activeAlerts: [Alert] = alerts.filter { $0.isActive }
            return activeAlerts
        }
    }
    
    func createAlert(identifier: Identifier) {
        var newAlert = Alert(item: identifier)
        self.alerts.append(newAlert)
    }
    
    func deleteAlert(identifier: Identifier) {
        
    }
}
