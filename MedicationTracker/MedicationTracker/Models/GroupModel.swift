//
//  GroupModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class Group: Identifier, Equatable, Codable {
    
    var name: String
    var status: Status {
        didSet {
            switch status {
            case .done:
                muteAlerts()
            case .cancelled:
                print("cancelled")
            case .standby:
                for alert in alerts {
                    alert.createAlerts()
                }
            case .skipped:
                print("You shouldn't be here")
            }
        }
    }
    var items: [Item]
    var alerts: [Alert] = []
    
    init(name: String, items: [Item]) {
        self.name = name
        self.status = .standby
        self.items = items
    }
    
    // MARK: - Methods
    
    func muteAlerts() {
        print("Outside the for loop")
        print("Alerts count: \(alerts.count)")
        for alert in alerts {
            print("we get here")
            alert.muteAlert(for: alert)
        }
    }
    
    // MARK: - Equatable
    
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name && lhs.status == rhs.status && lhs.items == rhs.items && lhs.alerts == rhs.alerts
    }
}
