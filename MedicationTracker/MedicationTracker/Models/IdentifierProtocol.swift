//
//  IdentifierProtocol.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

protocol Identifier: Decodable, Encodable {
    var name: String { get set }
    func encode(to encoder: Encoder) throws
    
}

