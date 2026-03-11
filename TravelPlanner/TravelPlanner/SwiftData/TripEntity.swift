//
//  TripEntity.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 3/4/26.
//

import SwiftData
import Foundation

@Model
class TripEntity {

    var city: String
    var startDate: Date
    var endDate: Date
    var userId: String
    
    var planData: Data

    init(
        city: String,
        startDate: Date,
        endDate: Date,
        userId: String,
        planData: Data
    ) {
        self.city = city
        self.startDate = startDate
        self.endDate = endDate
        self.userId = userId
        self.planData = planData
    }
}
