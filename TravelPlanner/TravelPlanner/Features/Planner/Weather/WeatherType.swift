//
//  WeatherType.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/28/26.
//

import Foundation

enum WeatherType {
    case clear
    case cloudy
    case fog
    case drizzle
    case snow
    case rain
    case thunderstorm
    
    var icon: String {
        switch self {
        case .clear: return "sun.max.fill"
        case .cloudy: return "cloud.sun.fill"
        case .fog: return "cloud.fog.fill"
        case .drizzle: return "cloud.drizzle.fill"
        case .snow: return "cloud.snow.fill"
        case .rain: return "cloud.rain.fill"
        case .thunderstorm: return "cloud.bolt.fill"
        }
    }
    
    static func from(code: Int) -> WeatherType {
        switch code {
        case 0: return .clear
        case 1...3: return .cloudy
        case 45, 48: return .fog
        case 51...67: return .drizzle
        case 71...77: return .snow
        case 80...82: return .rain
        case 95...99: return .thunderstorm
        default: return .cloudy
        }
    }
}
