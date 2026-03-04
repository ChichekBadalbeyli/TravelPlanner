//
//  WeatherMode.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

struct WeatherDay: Identifiable {
    let id = UUID()
    let day: String
    let temperature: Int
    let weatherCode: Int
}
