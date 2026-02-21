//
//  LoginViewModel.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    
    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    private let authService = AuthService()
    
    func login(appState: AppState) async {
        do {
            try await authService.login(email: email, password: password)
            appState.isAuthenticated = true
        }
        catch {
            errorMessage = error.localizedDescription
        }
    }
    
}
