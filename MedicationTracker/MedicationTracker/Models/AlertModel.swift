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
//    var item: Item?
    var isActive: Bool {
        didSet {
            if isActive {
                group!.status = .standby
            } else {
                group!.status = .done
            }
        }
    }
    
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
        
            content.body = "Remember to take your \(group.name) supplements! "
            for items in group.items {
                content.body += "\(items.name) "
        }
                
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 120, repeats: true)
        
        let request = UNNotificationRequest(identifier: group.name, content: content, trigger: trigger)
        center.add(request)
        print("Created Alert for \(group.name)")
        
    }
    
    // MARK: - Methods
    
    func muteAlert() {
        printAlerts()
        let center = UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: [self.group!.name])
        center.removePendingNotificationRequests(withIdentifiers: [self.group!.name])
        printAlerts()
    }
    
    func printAlerts() {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { (notifications) in
            print("Notifications count: \(notifications.count)")
            for item in notifications {
                print(item.identifier)
            }
        }
    }
    
    
    // MARK: - Equatable
    
    static func == (lhs: Alert, rhs: Alert) -> Bool {
        return lhs.group?.name == rhs.group?.name && lhs.isActive == rhs.isActive
    }
    
}
