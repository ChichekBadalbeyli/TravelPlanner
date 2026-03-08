//
//  LoginView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel: LoginViewModel
    @EnvironmentObject var appState: AppState
    @EnvironmentObject private var authCoordinator: AuthFlowCoordinator

    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            AppGradient()
            VStack(spacing: 40) {
                headImage
                AppCard {
                    VStack(spacing: 20) {
                        loginTextField
                        loginButton
                        registerButton
                        errorLabel
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    var headImage: some View {
        VStack(spacing: 40) {
            VStack(spacing: 12) {
                Image(systemName: L10n.Icon.airplane)
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                
                Text(L10n.App.name)
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
            }
        }
    }
    
    var loginTextField: some View {
        VStack {
            AppTextField(
                placeholder: L10n.Auth.email,
                text: $viewModel.email
            )
            
            AppSecureField(
                placeholder: L10n.Auth.password,
                text: $viewModel.password
            )
        }
    }
    
    var loginButton: some View {
        AppPrimaryButton(title: L10n.Auth.login) {
            Task {
                await viewModel.login(appState: appState)
            }
        }
        .disabled(!viewModel.isFormValid)
        .opacity(viewModel.isFormValid ? 1 : 0.5)
    }
    
    var registerButton: some View {
        Button {
            authCoordinator.registrationDestination = RegistrationDestination()
        } label: {
            Text(L10n.Auth.noAccount)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
    var errorLabel: some View {
        VStack {
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
    }
}
