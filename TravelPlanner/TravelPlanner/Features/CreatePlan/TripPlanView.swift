//
//  PlanView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/28/26.
//

import Foundation
import SwiftUI
import SwiftData

struct TripPlanView: View {
  
  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject private var appState: AppState
  @State private var saveErrorMessage: String?
  let isSavedTrip: Bool
  let city: String
  let startDate: Date
  let endDate: Date
  
  let plan: TripPlan
  
  var body: some View {
    ScrollView {
      VStack(spacing: 24) {
        ForEach(plan.days) { day in
          VStack(alignment: .leading, spacing: 12) {
            Text(formatted(day.date))
              .font(.headline)
            ForEach(day.places) { place in
              Text("• \(place.name)")
                .padding(.leading)
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()
          .background(Color.white)
          .cornerRadius(16)
          .shadow(radius: 3)
        }
        if !isSavedTrip {
          AppPrimaryButton(title: "Save Trip") {
            saveTrip()
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      .padding()
    }
    .navigationTitle("Your Plan")
  }
  
  func formatted(_ date: Date) -> String {
    DateFormatters.medium.string(from: date)
  }
  
  private func saveTrip() {
    do {
      guard let uid = appState.currentUserId else { return }
      let repository = DefaultTripsRepository(context: context)
      try repository.saveTrip(
        city: city,
        startDate: startDate,
        endDate: endDate,
        userId: uid,
        plan: plan
      )
      dismiss()
    } catch {
      saveErrorMessage = "Trip could not be saved. Please try again"
    }
  }
}
