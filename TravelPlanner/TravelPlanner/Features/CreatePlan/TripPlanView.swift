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
  @Environment(\.appDependencies) private var dependencies
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
              Text(String(format: L10n.Plan.placeFormat, place.name))
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
          AppPrimaryButton(title: L10n.Plan.saveTrip) {
            saveTrip()
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      .padding()
    }
    .navigationTitle(L10n.Plan.title)
  }
  
  func formatted(_ date: Date) -> String {
    DateFormatters.medium.string(from: date)
  }
  
  private func saveTrip() {
    do {
      guard let uid = appState.currentUserId else { return }
      let repository = dependencies.makeTripsRepository(context)
      let useCase = DefaultSaveTripUseCase(repository: repository)
      try useCase.execute(city: city, startDate: startDate, endDate: endDate, userId: uid, plan: plan)
      dismiss()
    } catch {
      saveErrorMessage = L10n.Plan.saveError
    }
  }
}
