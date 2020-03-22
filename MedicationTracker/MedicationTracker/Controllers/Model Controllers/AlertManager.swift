//
//  AlertManager.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation
import UserNotifications

class AlertManager: Codable {
    
    static var alertManager = AlertManager()
    
    var alerts: [Alert] = []
    var activeAlerts: [Alert] {
        get {
            let activeAlerts: [Alert] = alerts.filter { $0.isActive }
            return activeAlerts
        }
    }
    
    func createAlert(identifier: Identifier) {
        let newAlert = Alert(item: identifier)
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
    
    func deleteAlert2(at alert: Alert) {
        self.alerts.removeAll(where: {$0 == alert})
    }
    
    
    func nukeAlerts() {
        // Will delete ALL notifications. For debugging purposes only
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
    
    // MARK: - Data Permanence Functionality
    var alertURL: URL? {
    get {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let plistFile = documentsDir.appendingPathComponent("AlertTrackers2.plist")
        
        return plistFile
        
        }
    }
    
    func saveToPersistentStore() {
        
        guard let plistURL = alertURL else { return }
        let propertyList = PropertyListEncoder()
        
        do {
            let alertsData = try propertyList.encode(AlertManager.alertManager.alerts)
            try alertsData.write(to: plistURL)
            print("Saved alerts array: \(AlertManager.alertManager.alerts)")
        } catch {
            print("Error encoding Alerts: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let plistURL = alertURL else { return }
            let data = try Data(contentsOf: plistURL)
            let plistDecoder = PropertyListDecoder()
            let decodedAlerts = try plistDecoder.decode([Alert].self , from: data)
            AlertManager.alertManager.alerts = decodedAlerts
            print("Loaded alerts array: \(alerts)")
        } catch {
            print("Failed to load decoded Alerts array: \(error)")
        }
    }
}
