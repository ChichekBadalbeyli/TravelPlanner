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
                Label(Localization.Tab.create, systemImage: Localization.Icon.plusCircle)
            }
            .tag(0)

            NavigationStack {
                MyTripsView()
                    .environmentObject(myTripsCoordinator)
            }
            .tabItem {
                Label(Localization.Tab.trips, systemImage: Localization.Icon.map)
            }
            .tag(1)

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label(Localization.Tab.profile, systemImage: Localization.Icon.person)
            }
            .tag(2)
        }
    }
}
