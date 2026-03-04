//
//  ForecastResponse.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

struct GeocodeResponse: Decodable {
    let results: [GeocodeResult]?
}

struct GeocodeResult: Decodable {
    let latitude: Double
    let longitude: Double
}

struct ForecastResponse: Decodable {
    let daily: Daily
}

struct Daily: Decodable {
    let time: [String]
    let temperature_2m_max: [Double]
    let weathercode: [Int]
}
