//
//  PlaceDetailsUseCase.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

protocol FetchPlaceDetailsUseCase {
    func execute(id: String) async throws -> PlaceDetails
}

struct DefaultFetchPlaceDetailsUseCase: FetchPlaceDetailsUseCase {
    let placesRepository: PlacesRepository

    func execute(id: String) async throws -> PlaceDetails {
        try await placesRepository.fetchPlaceDetails(id: id)
    }
}

