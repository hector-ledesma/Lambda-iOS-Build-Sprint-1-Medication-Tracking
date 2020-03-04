//
//  DayModel.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

struct Day {
    var day: String // This will be calendar data.
    var alerts: [Alert] = []
    
    init(day: String, alerts: [Alert] = []) {
        self.day = day
        self.alerts = alerts
    }
}
