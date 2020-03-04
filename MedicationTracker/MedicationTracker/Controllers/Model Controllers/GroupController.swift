//
//  GroupController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class GroupController {
    var groups: [Group] = [Group(name: "Group A", items: [Item(name: "Vitamin D", description: "PRAISE THE SUN"), Item(name: "Iron", description: "STEEL RESOLVE")])]
    
    func create(name: String, items: [Item]) {
        let newGroup = Group(name: name, items: items)
        self.groups.append(newGroup)
    }
    
    func newAlerts() {
        
    }
    
    func muteAlerts() {
        
    }
}
