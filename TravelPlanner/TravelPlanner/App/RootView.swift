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
    @Environment(\.appDependencies) private var dependencies

    var body: some View {
        if appState.isAuthenticated {
            MainTabView()
        } else {
            NavigationStack {
                LoginView(
                    viewModel: LoginViewModel(
                        loginUseCase: DefaultLoginUseCase(authService: dependencies.authService)
                    ),
                    registrationViewModel: RegistrationViewModel(
                        registerUseCase: DefaultRegisterUseCase(authService: dependencies.authService)
                    )
                )
            }
        }
    }
}
