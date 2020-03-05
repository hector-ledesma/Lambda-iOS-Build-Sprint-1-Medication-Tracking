//
//  ItemController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class ItemController: Codable {
    var items: [Item] = [Item(name: "Vitamin D", description: "PRAISE THE SUN"), Item(name: "Iron", description: "STEEL RESOLVE")]
    
    func create(name: String, description: String) {
        var newItem = Item(name: name, description: description)
        self.items.append(newItem)
    }
    
    func update(name: String) {
        
    }
    
//    // MARK: - Data Permanence Functionality
//    var medicationTrackerURL: URL? {
//    get {
//        let fileManager = FileManager.default
//        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
//        let plistFile = documentsDir.appendingPathComponent("MedicineTracker.plist")
//        
//        return plistFile
//        
//        }
//    }
//    
//    func saveToPersistentStore() {
//        
//        guard let plistURL = medicationTrackerURL else { return }
//        let propertyList = PropertyListEncoder()
//        
//        do {
//            let itemsData = try propertyList.encode(items)
//            try itemsData.write(to: plistURL)
//        } catch {
//            print("Error encoding Items: \(error)")
//        }
//    }
//    
//    func loadFromPersistentStore() {
//        do {
//            guard let plistURL = medicationTrackerURL else { return }
//            let data = try Data(contentsOf: plistURL)
//            let plistDecoder = PropertyListDecoder()
//            let decodedItems = try plistDecoder.decode([Item].self , from: data)
//            items = decodedItems
//            
//        } catch {
//            print("Failed to load decoded Items array: \(error)")
//        }
//    }
    
}
