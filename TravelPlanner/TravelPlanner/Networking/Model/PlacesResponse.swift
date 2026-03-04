//
//  PlaceResponce.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

struct PlacesResponse: Decodable {
    let features: [Place]
}
