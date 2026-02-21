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
                CreatePlanView()
            }
            .tabItem {
                Label("Create", systemImage: "plus.circle")
            }

            NavigationStack {
                MyTripsView()
            }
            .tabItem {
                Label("Trips", systemImage: "map")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }
}
