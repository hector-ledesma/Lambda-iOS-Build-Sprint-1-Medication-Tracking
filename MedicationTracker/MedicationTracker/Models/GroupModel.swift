//
//  GroupModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class Group: Identifier {
    var name: String
    var status: Status
    var items: [Item]
    var alerts: [Alert] = []
    
    init(name: String, items: [Item]) {
        self.name = name
        self.status = .standby
        self.items = items
    }
}
