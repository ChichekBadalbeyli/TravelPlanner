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
        string(forKey: "GEOAPIFY_API_KEY") ?? ""
    }
}
