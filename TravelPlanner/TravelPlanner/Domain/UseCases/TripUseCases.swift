import Foundation
import SwiftData

protocol SaveTripUseCase {
    func execute(
        city: String,
        startDate: Date,
        endDate: Date,
        userId: String,
        plan: TripPlan
    ) throws
}

struct DefaultSaveTripUseCase: SaveTripUseCase {
    let repository: TripsRepository

    func execute(
        city: String,
        startDate: Date,
        endDate: Date,
        userId: String,
        plan: TripPlan
    ) throws {
        try repository.saveTrip(
            city: city,
            startDate: startDate,
            endDate: endDate,
            userId: userId,
            plan: plan
        )
    }
}

