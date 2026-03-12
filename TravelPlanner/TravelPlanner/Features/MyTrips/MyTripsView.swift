//
//  MyTripsView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import SwiftUI
import SwiftData

struct MyTripsView: View {
    
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var coordinator: MyTripsCoordinator
    @Query(sort: \TripEntity.startDate, order: .reverse)
    private var allTrips: [TripEntity]
    
  var body: some View {
      Group {
          if trips.isEmpty {
              emptyState
          } else {
              tripsList
          }
      }
      .navigationTitle(Localization.Trips.title)
      .alert(isPresented: $coordinator.showDeleteAlert) {
          deleteAlert()
      }
      .sheet(item: $coordinator.selectedTrip) { trip in
          TripPlanView(
              isSavedTrip: true,
              city: trip.city,
              startDate: trip.startDate,
              endDate: trip.endDate,
              plan: decodePlan(from: trip)
          )
          .presentationDetents([.large])
      }
  }
    
    private func decodePlan(from trip: TripEntity) -> TripPlan {
        let repository = DefaultTripsRepository(context: context)
        return repository.decodePlan(from: trip)
    }
    
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: Localization.Icon.airplane)
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text(Localization.Trips.emptyTitle)
                .font(.headline)
            
            Text(Localization.Trips.emptySubtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var trips: [TripEntity] {
        guard let uid = appState.currentUserId else { return [] }
        return allTrips.filter { $0.userId == uid }
    }
    
    private var tripsList: some View {
        List {
            ForEach(trips) { trip in
                tripRow(trip)
                    .onTapGesture {
                        coordinator.showTrip(trip)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            coordinator.askDelete(trip)
                        } label: {
                            Label(Localization.Trips.delete, systemImage: Localization.Icon.trash)
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
        }
        .padding(.vertical, 4)
    }
    
    private func deleteAlert() -> Alert {
        Alert(
            title: Text(Localization.Trips.deleteTitle),
            message: Text(Localization.Trips.deleteMessage),
            primaryButton: .destructive(Text(Localization.Trips.delete)) {
                if let trip = coordinator.tripToDelete {
                    context.delete(trip)
                    try? context.save()
                    coordinator.clearDelete()
                }
            },
            secondaryButton: .cancel(Text(Localization.Common.cancel))
        )
    }
    
    private func dateRange(_ trip: TripEntity) -> String {
        let start = DateFormatters.medium.string(from: trip.startDate)
        let end = DateFormatters.medium.string(from: trip.endDate)
        return String(format: Localization.City.dateRangeFormat, start, end)
    }
}

