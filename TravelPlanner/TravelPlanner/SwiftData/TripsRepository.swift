//
//  TripsRepository.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 3/4/26.
//

import Foundation
import SwiftData

protocol TripsRepository {
    func saveTrip(
        city: String,
        startDate: Date,
        endDate: Date,
        userId: String,
        plan: TripPlan
    ) throws
    
    func decodePlan(from trip: TripEntity) -> TripPlan
}

struct DefaultTripsRepository: TripsRepository {
    
    let context: ModelContext
    
    func saveTrip(
        city: String,
        startDate: Date,
        endDate: Date,
        userId: String,
        plan: TripPlan
    ) throws {
        let data = try JSONEncoder().encode(plan)
        let trip = TripEntity(
            city: city,
            startDate: startDate,
            endDate: endDate,
            userId: userId,
            planData: data
        )
        context.insert(trip)
        try context.save()
    }
    
    func decodePlan(from trip: TripEntity) -> TripPlan {
        do {
            return try JSONDecoder().decode(TripPlan.self, from: trip.planData)
        } catch {
            return TripPlan(days: [])
        }
    }
}

