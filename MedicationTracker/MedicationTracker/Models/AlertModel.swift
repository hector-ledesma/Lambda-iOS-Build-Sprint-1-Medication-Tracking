//
//  AlertModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation
import UserNotifications

class Alert: Equatable {
    
    
    var identifier: Identifier
    var isActive: Bool
    
    init(item: Identifier) {
        self.identifier = item
        self.isActive = true
        
        createAlerts()
    }
    
    func createAlerts() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Time for gains!"
        if let group = self.identifier as? Group {
            content.body = "Remember tou take your \(group.name) supplements! "
            for items in group.items {
                content.body += "\(items.name) "
            }
        }
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        let request = UNNotificationRequest(identifier: self.identifier.name, content: content, trigger: trigger)
        center.add(request)
        print("Created Alert for \(self.identifier.name)")
        
    }
    
    static func == (lhs: Alert, rhs: Alert) -> Bool {
        return lhs.identifier.name == rhs.identifier.name && lhs.isActive == rhs.isActive
    }
}
