//
//  MainTabBarView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import SwiftUI

struct MainTabView: View {

    @StateObject private var myTripsCoordinator = MyTripsCoordinator()
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            NavigationStack {
                    SearchView()
            }
            .tabItem {
                Label(L10n.Tab.create, systemImage: L10n.Icon.plusCircle)
            }
            .tag(0)

            NavigationStack {
                MyTripsView()
                    .environmentObject(myTripsCoordinator)
            }
            .tabItem {
                Label(L10n.Tab.trips, systemImage: L10n.Icon.map)
            }
            .tag(1)

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label(L10n.Tab.profile, systemImage: L10n.Icon.person)
            }
            .tag(2)
        }
    }
}
