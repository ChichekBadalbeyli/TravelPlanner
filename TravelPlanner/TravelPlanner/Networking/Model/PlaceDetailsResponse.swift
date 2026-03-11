//
//  PlaceDetailResponce.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/28/26.
//

import Foundation

struct PlaceDetailsResponse: Decodable {
    let features: [PlaceDetailsFeature]
}

struct PlaceDetailsFeature: Decodable {
    let properties: PlaceDetails
}

struct PlaceDetails: Decodable {
    let name: String?
    let formatted: String?
    let website: String?
    let phone: String?
    let openingHours: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case formatted
        case website
        case phone
        case openingHours = "opening_hours"
    }
}
