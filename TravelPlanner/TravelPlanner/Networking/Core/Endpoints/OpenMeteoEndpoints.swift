//
//  OpenMeteoEndpoints.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

import Foundation

enum OpenMeteoEndpoints {
    case geocode(city: String)
    case forecast(
        latitude: Double,
        longitude: Double,
        startDate: String,
        endDate: String
    )
}

extension OpenMeteoEndpoints: Endpoint {
    
    var baseURL: String {
        switch self {
        case .geocode:
            return "https://geocoding-api.open-meteo.com"
        case .forecast:
            return "https://api.open-meteo.com"
        }
    }
    
    var path: String {
        switch self {
        case .geocode:
            return "/v1/search"
        case .forecast:
            return "/v1/forecast"
        }
    }
    
    var method: HttpMethod { .get }
    
    var headers: [String : String]? { [:] }
    
    var queryItems: [URLQueryItem]? {
        switch self {
            
        case .geocode(let city):
            return [
                .init(name: "name", value: city),
                .init(name: "count", value: "1")
            ]
            
        case .forecast(let lat, let lon, let start, let end):
            return [
                .init(name: "latitude", value: "\(lat)"),
                .init(name: "longitude", value: "\(lon)"),
                .init(name: "daily", value: "temperature_2m_max,weathercode"),
                .init(name: "timezone", value: "auto"),
                .init(name: "start_date", value: start),
                .init(name: "end_date", value: end)
            ]
        }
    }
    
    var httpBody: Encodable? { nil }
}
