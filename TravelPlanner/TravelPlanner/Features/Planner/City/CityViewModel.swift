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
    
    @Published private(set) var loadState: Loadable<CityData> = .idle
    @Published var selectedPlace: Place?
    @Published var showError = false
    @Published var errorMessage: String?
    @Published var details: PlaceDetails?
    @Published var generatedPlan: TripPlan?
    
    private let fetchCityDataUseCase: FetchCityDataUseCase
    private let generateTripPlanUseCase: GenerateTripPlanUseCase
    
    init(
        fetchCityDataUseCase: FetchCityDataUseCase,
        generateTripPlanUseCase: GenerateTripPlanUseCase
    ) {
        self.fetchCityDataUseCase = fetchCityDataUseCase
        self.generateTripPlanUseCase = generateTripPlanUseCase
    }
    
    var hasSelectedPlaces: Bool {
        places.contains(where: { $0.isAdded })
    }

    var weather: [WeatherDay] { loadState.value?.weather ?? [] }
    var places: [Place] { loadState.value?.places ?? [] }
    var isLoading: Bool { loadState.isLoading }
    
    // MARK: - Load
    
    func load(city: String, startDate: Date, endDate: Date) {
        let calendar = Calendar.current
        let maxWeatherEnd = calendar.date(byAdding: .day, value: 14, to: startDate) ?? endDate
        let weatherEndDate = min(endDate, maxWeatherEnd)
        Task {
            await fetchAll(
                city: city,
                startDate: startDate,
                endDate: weatherEndDate
            )
        }
    }
    
    private func fetchAll(city: String,
                          startDate: Date,
                          endDate: Date) async {
        loadState = .loading
        do {
            let data = try await fetchCityDataUseCase.execute(
                city: city,
                startDate: startDate,
                endDate: endDate
            )
            loadState = .loaded(data)
        }
        catch {
            loadState = .failed(error)
            showError = true
            if let localized = (error as? LocalizedError)?.errorDescription {
                errorMessage = localized
            } else {
                errorMessage = L10n.City.loadError
            }
        }
    }
    
    // MARK: - Add / Remove
    
    func togglePlace(_ place: Place) {
        guard case .loaded(var data) = loadState else { return }
        guard let index = data.places.firstIndex(where: { $0.id == place.id }) else { return }
        data.places[index].isAdded.toggle()
        loadState = .loaded(data)
    }
    
    // MARK: - Plan
    
    func generatePlan(startDate: Date, endDate: Date) {
        generatedPlan = generateTripPlanUseCase.execute(
            places: places,
            startDate: startDate,
            endDate: endDate
        )
    }
}
