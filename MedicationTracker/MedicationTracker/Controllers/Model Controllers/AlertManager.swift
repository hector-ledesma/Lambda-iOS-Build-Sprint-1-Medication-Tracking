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
    
    func createAlert(identifier: Identifier) {
        let newAlert = Alert(item: identifier)
        self.alerts.append(newAlert)
    }
}
