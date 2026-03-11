//
//  RegistrationView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI

struct RegistrationView: View {

    @StateObject private var viewModel: RegistrationViewModel
    @EnvironmentObject var appState: AppState

    init(viewModel: RegistrationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            AppGradient()
            VStack(spacing: 40) {
                headImage
                AppCard {
                    VStack(spacing: 20) {
                        registerText
                        registerButton
                        errorMessage
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    var headImage: some View {
        VStack(spacing: 40) {
            VStack(spacing: 12) {
                Image(systemName: L10n.Icon.globe)
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                Text(L10n.Auth.createAccount)
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
            }
        }
    }
    
    var registerText: some View {
        VStack {
            AppTextField(
                placeholder: L10n.Auth.email,
                text: $viewModel.email
            )
            AppSecureField(
                placeholder: L10n.Auth.password,
                text: $viewModel.password
            )
            AppSecureField(
                placeholder: L10n.Auth.confirmPassword,
                text: $viewModel.confirmPassword
            )
        }
    }
    
    var registerButton: some View {
        AppPrimaryButton(title: L10n.Auth.register) {
            Task {
                await viewModel.register(appState: appState)
            }
        }
        .disabled(!viewModel.isFormValid)
        .opacity(viewModel.isFormValid ? 1 : 0.5)
    }
    
    var errorMessage: some View {
        VStack {
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
    }
}
