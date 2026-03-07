//
//  TravelPlannerApp.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI
import FirebaseCore
import SwiftData

@main
struct TravelPlannerApp: App {

    @StateObject private var appState: AppState
    
    init()  {
        let isFirebaseConfigured = Self.configureFirebaseIfPossible()
        _appState = StateObject(wrappedValue: AppState(isFirebaseConfigured: isFirebaseConfigured))
    }

    var body: some Scene {
        WindowGroup {
                RootView()
                    .environmentObject(appState)
            }
        .modelContainer(for: [TripEntity.self])
    }
}

private extension TravelPlannerApp {
    static func configureFirebaseIfPossible() -> Bool {
        if FirebaseApp.app() != nil {
            return true
        }

        guard Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil else {
            assertionFailure("Missing GoogleService-Info.plist. Add it at TravelPlanner/GoogleService-Info.plist (see README).")
            return false
        }

        FirebaseApp.configure()
        return FirebaseApp.app() != nil
    }
}
