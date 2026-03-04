//
//  PlanView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/28/26.
//

import Foundation
import SwiftUI
import SwiftData
import FirebaseAuth

struct TripPlanView: View {
    
    @Environment(\.modelContext) private var context
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
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func saveTrip() {

        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user logged in")
            return
        }

        let allPlaces = plan.days
            .flatMap { $0.places }
            .map { $0.name }

        let trip = TripEntity(
            city: city,
            startDate: startDate,
            endDate: endDate,
            places: allPlaces,
            userId: uid
        )

        context.insert(trip)

        do {
            try context.save()
            print("Trip saved")
        } catch {
            print(error)
        }
    }
}
