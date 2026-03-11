//
//  AuthFlowCoordinator.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import Combine
@MainActor
final class AuthFlowCoordinator: ObservableObject {
    @Published var registrationDestination: RegistrationDestination?
}

struct RegistrationDestination: Identifiable, Hashable {
    let id = UUID()
}

