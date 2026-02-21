//
//  ProfileView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Text("Profile")

            Button("Logout") {
                appState.isAuthenticated = false
            }
        }
    }
}
