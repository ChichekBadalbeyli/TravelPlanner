import Foundation

protocol PlacesRepository {
    func fetchPlaces(latitude: Double, longitude: Double) async throws -> [Place]
    func fetchPlaceDetails(id: String) async throws -> PlaceDetails
}

struct DefaultPlacesRepository: PlacesRepository {
    let network: NetworkService

    init(network: NetworkService) {
        self.network = network
    }

    func fetchPlaces(latitude: Double, longitude: Double) async throws -> [Place] {
        let response: PlacesResponse = try await network.request(
            GeoapifyEndpoints.places(latitude: latitude, longitude: longitude)
        )
        return response.features
    }

    func fetchPlaceDetails(id: String) async throws -> PlaceDetails {
        let response: PlaceDetailsResponse = try await network.request(
            GeoapifyEndpoints.placeDetails(id: id)
        )
        guard let details = response.features.first?.properties else {
            throw NetworkError.noData
        }
        return details
    }
}

