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
    
    @Published private(set) var loadState: Loadable<PlaceDetails> = .idle
    @Published var errorMessage: String?
    
    private let fetchPlaceDetailsUseCase: FetchPlaceDetailsUseCase
    
    init(fetchPlaceDetailsUseCase: FetchPlaceDetailsUseCase) {
        self.fetchPlaceDetailsUseCase = fetchPlaceDetailsUseCase
    }
    
    func loadDetails(for id: String) {
        Task {
            await fetchDetails(id: id)
        }
    }
    
    private func fetchDetails(id: String) async {
        loadState = .loading
        do {
            loadState = .loaded(try await fetchPlaceDetailsUseCase.execute(id: id))
        } catch {
            loadState = .failed(error)
            if let localized = (error as? LocalizedError)?.errorDescription {
                errorMessage = localized
            } else {
                errorMessage = L10n.PlaceDetails.loadError
            }
        }
    }

    var details: PlaceDetails? { loadState.value }
    var isLoading: Bool { loadState.isLoading }
}
