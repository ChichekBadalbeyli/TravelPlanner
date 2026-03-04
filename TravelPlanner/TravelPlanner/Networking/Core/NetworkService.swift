//
//  NetworkService.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

protocol NetworkService {
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
