//
//  AppConfig.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 3/6/26.
//

import Foundation

enum AppConfig {
    
    private static func string(forKey key: String) -> String? {
        Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
    
    static var geoapifyApiKey: String {
        let value = (string(forKey: "GEOAPIFY_API_KEY") ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if value.isEmpty || value.hasPrefix("$(") {
            assertionFailure("Missing GEOAPIFY_API_KEY. Set GEOAPIFY_API_KEY as an Xcode build setting (User-Defined) or via an .xcconfig file.")
            return ""
        }
        return value
    }
}
