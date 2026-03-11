//
//  AppState.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import FirebaseCore

@MainActor
final class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isFirebaseConfigured: Bool
    @Published var selectedTab: Int = 0
    
    private let authService: AuthServicing
    
    init(
        isFirebaseConfigured: Bool = FirebaseApp.app() != nil,
        authService: AuthServicing = AuthService()
    ) {
        self.isFirebaseConfigured = isFirebaseConfigured
        self.authService = authService
        isAuthenticated = isFirebaseConfigured ? authService.isUserLoggedIn() : false
    }
    
    func logout() {
        guard isFirebaseConfigured else {
            isAuthenticated = false
            return
        }

        try? authService.logout()
        isAuthenticated = false
    }

    var currentUserId: String? {
        guard isFirebaseConfigured else { return nil }
        return Auth.auth().currentUser?.uid
    }

    var currentUserEmail: String? {
        guard isFirebaseConfigured else { return nil }
        return Auth.auth().currentUser?.email
    }
}
