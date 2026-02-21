//
//  LoginView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import SwiftUI

struct LoginView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")

            Button("Mock Login") {
                appState.isAuthenticated = true
            }
        }
    }
}
