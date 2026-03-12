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
        case .clear: return Localization.Icon.sunMaxFill
        case .cloudy: return Localization.Icon.cloudSunFill
        case .fog: return Localization.Icon.cloudFogFill
        case .drizzle: return Localization.Icon.cloudDrizzleFill
        case .snow: return Localization.Icon.cloudSnowFill
        case .rain: return Localization.Icon.cloudRainFill
        case .thunderstorm: return Localization.Icon.cloudBoltFill
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
