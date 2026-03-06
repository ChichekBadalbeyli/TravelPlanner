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
    var places: [String]
    var userId: String

    init(city: String, startDate: Date, endDate: Date, places: [String], userId: String) {
        self.city = city
        self.startDate = startDate
        self.endDate = endDate
        self.places = places
        self.userId = userId
    }
}
