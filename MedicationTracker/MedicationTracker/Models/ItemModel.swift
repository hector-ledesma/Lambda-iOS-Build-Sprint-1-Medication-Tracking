//
//  ItemModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class Item: Identifier, Equatable, Codable {
    
    
    var name: String
    var status: Status
    var description: String
    var photoData: [Data]
    var groups: [Group] = []
    
    init(name: String, description: String, photoData: [Data] = []) {
        self.name = name
        self.status = .standby
        self.description = description
        self.photoData = photoData
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
    
}
