//
//  CityUseCases.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation
import CoreLocation

struct CityData {
    let weather: [WeatherDay]
    var places: [Place]
    let location: GeocodeResult
}

protocol FetchCityDataUseCase {
    func execute(city: String, startDate: Date, endDate: Date) async throws -> CityData
}

struct DefaultFetchCityDataUseCase: FetchCityDataUseCase {
    let weatherRepository: WeatherRepository
    let placesRepository: PlacesRepository

    func execute(city: String, startDate: Date, endDate: Date) async throws -> CityData {
        let location = try await weatherRepository.geocode(city: city)

        async let weatherTask = weatherRepository.fetchDailyForecast(
            latitude: location.latitude,
            longitude: location.longitude,
            startDate: startDate,
            endDate: endDate
        )
        async let placesTask = placesRepository.fetchPlaces(
            latitude: location.latitude,
            longitude: location.longitude
        )

        return CityData(
            weather: try await weatherTask,
            places: try await placesTask,
            location: location
        )
    }
}

protocol GenerateTripPlanUseCase {
    func execute(places: [Place], startDate: Date, endDate: Date) -> TripPlan?
}

struct DefaultGenerateTripPlanUseCase: GenerateTripPlanUseCase {
    func execute(places: [Place], startDate: Date, endDate: Date) -> TripPlan? {
        var remaining = places.filter { $0.isAdded }
        guard !remaining.isEmpty else { return nil }

        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        let daysCount = (calendar.dateComponents([.day], from: start, to: end).day ?? 0) + 1
        let maxPerDay = Int(ceil(Double(remaining.count) / Double(daysCount)))
        var days: [TripDay] = []
        for i in 0..<daysCount {
            guard !remaining.isEmpty else { break }
            guard let date = calendar.date(byAdding: .day, value: i, to: startDate) else { break }

            var dayPlaces: [Place] = []
            var current = remaining.removeFirst()
            dayPlaces.append(current)

            while dayPlaces.count < maxPerDay && !remaining.isEmpty {
                let nearest = remaining.min {
                    DefaultGenerateTripPlanUseCase.distance(from: current, to: $0) <
                        DefaultGenerateTripPlanUseCase.distance(from: current, to: $1)
                }
                if let next = nearest,
                   let index = remaining.firstIndex(where: { $0.id == next.id }) {
                    current = remaining.remove(at: index)
                    dayPlaces.append(current)
                }
            }

            days.append(TripDay(date: date, places: dayPlaces))
        }

        return TripPlan(days: days)
    }

    private static func distance(from: Place, to: Place) -> Double {
        let loc1 = CLLocation(latitude: from.lat, longitude: from.lon)
        let loc2 = CLLocation(latitude: to.lat, longitude: to.lon)
        return loc1.distance(from: loc2)
    }
}

