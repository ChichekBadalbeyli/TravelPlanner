//
//  PlaceDetailViewModel.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/28/26.
//

import Foundation
import Combine
import SwiftUI

final class PlaceDetailViewModel: ObservableObject {
    
    @Published var details: PlaceDetails?
    @Published var isLoading = false
    
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
            print("Failed to load details")
        }
    }
}
