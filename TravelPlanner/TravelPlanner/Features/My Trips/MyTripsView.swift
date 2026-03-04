//
//  MyTripsView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import SwiftUI
import SwiftData
import FirebaseAuth

struct MyTripsView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \TripEntity.startDate, order: .reverse)
    private var allTrips: [TripEntity]
    @State private var showDeleteAlert = false
    @State private var selectedTrip: TripEntity?
    @State private var tripToDelete: TripEntity?
    
    var body: some View {
        NavigationStack {
            tripsList
                .navigationTitle("My Trips")
                .alert(isPresented: $showDeleteAlert) {
                    deleteAlert()
                }
                .sheet(item: $selectedTrip) { trip in
                    TripPlanView(
                        isSavedTrip: true,
                        city: trip.city,
                        startDate: trip.startDate,
                        endDate: trip.endDate,
                        plan: makePlan(from: trip)
                    )
                    .presentationDetents([ .large])
                }
        }
    }
    
    private func makePlan(from trip: TripEntity) -> TripPlan {
        
        let calendar = Calendar.current
        var currentDate = trip.startDate
        
        let days = trip.places.map { placeName -> TripDay in
            
            let place = Place(
                id: UUID().uuidString,
                name: placeName,
                lat: 0,
                lon: 0,
                rating: 0,
            )
            
            let day = TripDay(
                date: currentDate,
                places: [place]
            )
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
            return day
        }
        
        return TripPlan(days: days)
    }
    
    private var trips: [TripEntity] {
        guard let uid = Auth.auth().currentUser?.uid else { return [] }
        return allTrips.filter { $0.userId == uid }
    }
    
    private var tripsList: some View {
        List {
            ForEach(trips) { trip in
                tripRow(trip)
                    .onTapGesture {
                        selectedTrip = trip
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            tripToDelete = trip
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
    }
    
    private func tripRow(_ trip: TripEntity) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(trip.city)
                .font(.headline)
            Text(dateRange(trip))
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("\(trip.places.count) places")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private func askDelete(at offsets: IndexSet) {
        if let index = offsets.first {
            tripToDelete = trips[index]
            showDeleteAlert = true
        }
    }
    
    private func deleteAlert() -> Alert {
        Alert(
            title: Text("Delete Trip"),
            message: Text("Are you sure you want to delete this trip?"),
            primaryButton: .destructive(Text("Delete")) {
                if let trip = tripToDelete {
                    context.delete(trip)
                    try? context.save()
                    tripToDelete = nil
                }
            },
            secondaryButton: .cancel()
        )
    }
    
    private func dateRange(_ trip: TripEntity) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return "\(formatter.string(from: trip.startDate)) - \(formatter.string(from: trip.endDate))"
    }
}

