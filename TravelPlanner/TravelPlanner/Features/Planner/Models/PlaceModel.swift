//
//  PlaceModel.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

struct Place: Identifiable, Decodable {
    
    let id: String
    let name: String
    let lat: Double
    let lon: Double
    let rating: Double?
    
    var isAdded: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case properties
    }
    
    enum PropertiesKeys: String, CodingKey {
        case place_id
        case name
        case lat
        case lon
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let properties = try container.nestedContainer(
            keyedBy: PropertiesKeys.self,
            forKey: .properties
        )
        
        id = try properties.decode(String.self, forKey: .place_id)
        name = try properties.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        lat = try properties.decode(Double.self, forKey: .lat)
        lon = try properties.decode(Double.self, forKey: .lon)
        rating = try? properties.decode(Double.self, forKey: .rating)
    }
}
