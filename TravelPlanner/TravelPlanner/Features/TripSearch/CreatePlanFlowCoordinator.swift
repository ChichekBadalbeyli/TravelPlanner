import Foundation
import SwiftUI
import Combine

@MainActor
final class CreatePlanFlowCoordinator: ObservableObject {
    @Published var citySelection: CitySelection?
    @Published var planDestination: PlanDestination?
}

struct CitySelection: Identifiable, Hashable {
    let id = UUID()
    let city: String
    let startDate: Date
    let endDate: Date
}

struct PlanDestination: Identifiable, Hashable {
    let id = UUID()
    let isSavedTrip: Bool
    let city: String
    let startDate: Date
    let endDate: Date
    let plan: TripPlan
}

