//
//  AlertModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation
import UserNotifications

class Alert: Equatable, Codable {
    
    
//    var identifier: Identifier
    var group: Group?
    var item: Item?
    var isActive: Bool
    
    init(item: Identifier) {
        if item is Group {
            self.group = (item as! Group)
        }
//        self.identifier = item
        self.isActive = true
        
        createAlerts()
    }
    
    func createAlerts() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Time for gains!"
        
        guard let group = self.group else { return }
        
            content.body = "Remember tou take your \(group.name) supplements! "
            for items in group.items {
                content.body += "\(items.name) "
        }
                
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        let request = UNNotificationRequest(identifier: group.name, content: content, trigger: trigger)
        center.add(request)
        print("Created Alert for \(group.name)")
        
    }
    
    static func == (lhs: Alert, rhs: Alert) -> Bool {
        return lhs.group?.name == rhs.group?.name && lhs.isActive == rhs.isActive
    }
    
}
