//
//  MainTabBarView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {
            NavigationStack {
                    SearchView()
            }
            .tabItem {
                Label(L10n.Tab.create, systemImage: L10n.Icon.plusCircle)
            }

            NavigationStack {
                MyTripsView()
            }
            .tabItem {
                Label(L10n.Tab.trips, systemImage: L10n.Icon.map)
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label(L10n.Tab.profile, systemImage: L10n.Icon.person)
            }
        }
    }
}
