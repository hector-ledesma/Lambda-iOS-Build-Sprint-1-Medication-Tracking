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
    
    func deleteAlert(identifier: Identifier) -> Bool {
        for existingAlert in alerts {
            if existingAlert.group?.name == identifier.name {
                guard let alertToBeDeleted = alerts.firstIndex(of: existingAlert) else { fatalError() }
                alerts.remove(at: alertToBeDeleted)
                return true
            }
        }
        return false
    }
    
    // MARK: - Data Permanence Functionality
    var medicationTrackerURL: URL? {
    get {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let plistFile = documentsDir.appendingPathComponent("MedicineTracker.plist")
        
        return plistFile
        
        }
    }
    
    func saveToPersistentStore() {
        
        guard let plistURL = medicationTrackerURL else { return }
        let propertyList = PropertyListEncoder()
        
        do {
            let alertsData = try propertyList.encode(alerts)
            try alertsData.write(to: plistURL)
        } catch {
            print("Error encoding Alerts: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let plistURL = medicationTrackerURL else { return }
            let data = try Data(contentsOf: plistURL)
            let plistDecoder = PropertyListDecoder()
            let decodedAlerts = try plistDecoder.decode([Alert].self , from: data)
            alerts = decodedAlerts
            
        } catch {
            print("Failed to load decoded Alerts array: \(error)")
        }
    }
}
