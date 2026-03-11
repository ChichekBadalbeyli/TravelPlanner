//
//  MyTripsCoordinator.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import Combine

@MainActor
final class MyTripsCoordinator: ObservableObject {
    @Published var selectedTrip: TripEntity?
    @Published var tripToDelete: TripEntity?
    @Published var showDeleteAlert = false
    
    func showTrip(_ trip: TripEntity) {
        selectedTrip = trip
    }
    
    func askDelete(_ trip: TripEntity) {
        tripToDelete = trip
        showDeleteAlert = true
    }
    
    func clearDelete() {
        tripToDelete = nil
        showDeleteAlert = false
    }
}

