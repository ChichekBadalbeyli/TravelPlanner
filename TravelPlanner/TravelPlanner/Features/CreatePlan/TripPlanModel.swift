//
//  TripPlan.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/28/26.
//

import Foundation

struct TripPlan: Identifiable, Codable, Equatable,Hashable {
    let id: UUID
    let days: [TripDay]

    init(id: UUID = UUID(), days: [TripDay]) {
        self.id = id
        self.days = days
    }
}

struct TripDay: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let date: Date
    let places: [Place]

    init(id: UUID = UUID(), date: Date, places: [Place]) {
        self.id = id
        self.date = date
        self.places = places
    }
}
