//
//  GeoapifyEndpoints.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

enum GeoapifyEndpoints {
    case places(latitude: Double, longitude: Double)
    case placeDetails(id: String)
    private var apiKey: String {
        AppConfig.geoapifyApiKey
    }
}

extension GeoapifyEndpoints: Endpoint {
    
    var baseURL: String {
        return "https://api.geoapify.com"
    }
    
    var path: String {
        switch self {
        case .places:
            return "/v2/places"
            
        case .placeDetails:
            return "/v2/place-details"
        }
    }
    
    var method: HttpMethod { .get }
    
    var headers: [String : String]? { [:] }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .places(let lat, let lon):
            return [
                .init(name: "categories", value: "tourism.sights"),
                .init(name: "filter", value: "circle:\(lon),\(lat),5000"),
                .init(name: "limit", value: "20"),
                .init(name: "apiKey", value: apiKey)
            ]
        case .placeDetails(let id):
            return [
                .init(name: "id", value: id),
                .init(name: "apiKey", value: apiKey)
            ]
        }
    }
    
    var httpBody: Encodable? { nil }
}
