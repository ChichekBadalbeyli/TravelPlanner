//
//  LoginView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState
    
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
                Image(systemName: "airplane")
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                
                Text("TravelPlanner")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
            }
        }
    }
    
    var loginTextField: some View {
        VStack {
            AppTextField(
                placeholder: "Email",
                text: $viewModel.email
            )
            
            AppSecureField(
                placeholder: "Password",
                text: $viewModel.password
            )
        }
    }
    
    var loginButton: some View {
        AppPrimaryButton(title: "Login") {
            Task {
                await viewModel.login(appState: appState)
            }
        }
        .disabled(!viewModel.isFormValid)
        .opacity(viewModel.isFormValid ? 1 : 0.5)
    }
    
    var registerButton: some View {
        NavigationLink(destination: RegistrationView()) {
            Text("Don't have an account? Register")
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
