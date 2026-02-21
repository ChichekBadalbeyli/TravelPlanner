//
//  TravelPlannerApp.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct TravelPlannerApp: App {

    @StateObject private var appState = AppState()
    
    init()  {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
                RootView()
                    .environmentObject(appState)
            }
    }
}
