//
//  GroupModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class Group: Identifier, Equatable {
    
    var name: String
    var status: Status
    var items: [Item]
    var alerts: [Alert] = []
    
    init(name: String, items: [Item]) {
        self.name = name
        self.status = .standby
        self.items = items
    }
    
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name && lhs.status == rhs.status && lhs.items == rhs.items && lhs.alerts == rhs.alerts
    }
}
