//
//  PlaceDetailViewModel.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/28/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class PlaceDetailViewModel: ObservableObject {
    
    @Published var details: PlaceDetails?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let network: NetworkService
    
    init(network: NetworkService = DefaultNetworkService()) {
        self.network = network
    }
    
    func loadDetails(for id: String) {
        Task {
            await fetchDetails(id: id)
        }
    }
    
    private func fetchDetails(id: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let response: PlaceDetailsResponse =
                try await network.request(
                    GeoapifyEndpoints.placeDetails(id: id)
                )
            details = response.features.first?.properties
        } catch {
            if let localized = (error as? LocalizedError)?.errorDescription {
                errorMessage = localized
            } else {
                errorMessage = "Failed to load place details."
            }
        }
    }
}
