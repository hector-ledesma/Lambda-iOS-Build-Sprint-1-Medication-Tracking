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
    
    func create(name: String, items: [Item], newAlert: Bool) {
        let newGroup = Group(name: name, items: items)
        self.groups.append(newGroup)
        
        //For the sake of sending the group from the controller as opposed to this temporary instance I'm doing this in a little bit of a convoluted way.
        let indexOfNewGroup = self.groups.firstIndex{ return newGroup }
        
    }
    
    func newAlerts(identifier: Identifier) {
        
    }
    
    func muteAlerts() {
        
    }
}
