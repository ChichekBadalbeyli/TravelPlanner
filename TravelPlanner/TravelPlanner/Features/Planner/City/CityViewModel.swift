//
//  CityViewModel.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

@MainActor
final class CityViewModel: ObservableObject {
    
    @Published var weather: [WeatherDay] = []
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage: String?
    @Published var navigateToPlan = false
    @Published var details: PlaceDetails?
    @Published var generatedPlan: TripPlan?
    
    private let network: NetworkService
    
    init(network: NetworkService = DefaultNetworkService()) {
        self.network = network
    }
    
    var hasSelectedPlaces: Bool {
        places.contains(where: { $0.isAdded })
    }
    
    // MARK: - Load
    
    func load(city: String, startDate: Date, endDate: Date) {
        Task {
            await fetchAll(city: city,
                           startDate: startDate,
                           endDate: endDate)
        }
    }
    
    private func fetchAll(city: String,
                          startDate: Date,
                          endDate: Date) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let location = try await fetchLocation(for: city)
            
            async let weatherTask = fetchWeather(
                location: location,
                startDate: startDate,
                endDate: endDate
            )
            async let placesTask = fetchPlaces(location: location)
            weather = try await weatherTask
            places = try await placesTask
        }
        catch {
            showError = true
            if let localized = (error as? LocalizedError)?.errorDescription {
                errorMessage = localized
            } else {
                errorMessage = "The information could not be loaded. Please check city name and try again."
            }
        }
    }
    
    private func fetchLocation(for city: String) async throws -> GeocodeResult {
        let geo: GeocodeResponse =
        try await network.request(
            OpenMeteoEndpoints.geocode(city: city)
        )
        
        guard let location = geo.results?.first else {
            throw NetworkError.noData
        }
        return location
    }
    
    private func fetchWeather(location: GeocodeResult,
                              startDate: Date,
                              endDate: Date) async throws -> [WeatherDay] {
        
        let start = DateFormatters.isoDay.string(from: startDate)
        let end = DateFormatters.isoDay.string(from: endDate)
        
        let forecast: ForecastResponse =
        try await network.request(
            OpenMeteoEndpoints.forecast(
                latitude: location.latitude,
                longitude: location.longitude,
                startDate: start,
                endDate: end
            )
        )
        return zip(
            forecast.daily.time,
            zip(
                forecast.daily.temperature_2m_max,
                forecast.daily.weathercode
            )
        ).map { dateString, values in
            
            let (temp, code) = values
            
            return WeatherDay(
                day: formattedDay(from: dateString),
                temperature: Int(temp),
                weatherCode: code
            )
        }
    }
    
    private func fetchPlaces(location: GeocodeResult) async throws -> [Place] {
        let response: PlacesResponse =
        try await network.request(
            GeoapifyEndpoints.places(
                latitude: location.latitude,
                longitude: location.longitude
            )
        )
        return response.features
    }
    
    // MARK: - Add / Remove
    
    func togglePlace(_ place: Place) {
        guard let index = places.firstIndex(where: { $0.id == place.id }) else { return }
        places[index].isAdded.toggle()
    }
    
    // MARK: - Plan
    
    func generatePlan(startDate: Date, endDate: Date) {
        var remaining = places.filter { $0.isAdded }
        guard !remaining.isEmpty else { return }
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        let daysCount = (calendar.dateComponents([.day], from: start, to: end).day ?? 0) + 1
        let maxPerDay = max(1, remaining.count / daysCount)
        var days: [TripDay] = []
        for i in 0..<daysCount {
            guard !remaining.isEmpty else { break }
            let date = Calendar.current.date(byAdding: .day, value: i, to: startDate)!
            var dayPlaces: [Place] = []
            var current = remaining.removeFirst()
            dayPlaces.append(current)
            while dayPlaces.count < maxPerDay && !remaining.isEmpty {
                let nearest = remaining.min {
                    distance(from: current, to: $0) <
                        distance(from: current, to: $1)
                }
                if let next = nearest,
                   let index = remaining.firstIndex(where: { $0.id == next.id }) {
                    
                    current = remaining.remove(at: index)
                    dayPlaces.append(current)
                }
            }
            days.append(
                TripDay(
                    date: date,
                    places: dayPlaces
                )
            )
        }
        generatedPlan = TripPlan(days: days)
        navigateToPlan = true
    }
    
    // MARK: - Helpers
    
    private func formattedDay(from string: String) -> String {
        guard let date = DateFormatters.isoDay.date(from: string) else {
            return string
        }
        
        return DateFormatters.shortWeekday.string(from: date)
    }
    
    private func distance(from: Place, to: Place) -> Double {
        let loc1 = CLLocation(latitude: from.lat, longitude: from.lon)
        let loc2 = CLLocation(latitude: to.lat, longitude: to.lon)
        return loc1.distance(from: loc2)
    }
}
