//
//  RootView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import SwiftUI

struct RootView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        if appState.isAuthenticated {
            MainTabView()
        } else {
            NavigationStack {
                LoginView()
            }
        }
    }
}
