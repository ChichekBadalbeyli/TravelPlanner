//
//  RegisterViewModel.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI
import Combine

final class RegisterViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage: String?
    
    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }

    private let authService = AuthService()

    func register(appState: AppState) async {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        do {
            try await authService.register(email: email, password: password)
            appState.isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
