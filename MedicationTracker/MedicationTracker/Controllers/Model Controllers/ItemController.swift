//
//  ItemController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class ItemController {
    var items: [Item] = [Item(name: "Vitamin D", description: "PRAISE THE SUN"), Item(name: "Iron", description: "STEEL RESOLVE")]
    
    func create(name: String, description: String) {
        let newItem = Item(name: name, description: description)
        self.items.append(newItem)
    }
    
    func update(name: String) {
        
    }
}
