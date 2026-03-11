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
    @StateObject private var authCoordinator = AuthFlowCoordinator()
    
    var body: some View {
        if appState.isAuthenticated {
            MainTabView()
                .onAppear {
                    appState.selectedTab = 0
                }
        } else {
            NavigationStack {
                LoginView(
                    viewModel: LoginViewModel(
                        loginUseCase: DefaultLoginUseCase(
                            authService: dependencies.authService
                        )
                    )
                )
                .environmentObject(authCoordinator)
                .navigationDestination(
                    item: $authCoordinator.registrationDestination
                ) { _ in
                    RegistrationView(
                        viewModel: RegistrationViewModel(
                            registerUseCase: DefaultRegisterUseCase(
                                authService: dependencies.authService
                            )
                        )
                    )
                    .environmentObject(authCoordinator)
                }
            }
        }
    }
}
