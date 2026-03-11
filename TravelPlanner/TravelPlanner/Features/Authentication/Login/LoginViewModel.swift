//
//  LoginViewModel.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
  
  @Published var email = ""
  @Published var password = ""
  @Published var errorMessage: String?
  
  var isFormValid: Bool {
    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
    
    return trimmedEmail.isValidEmail &&
    password.count >= 6
  }
  
    private let loginUseCase: LoginUseCase
  
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
  }
  
  func login(appState: AppState) async {
    errorMessage = nil
    
    if let validationError = validate() {
      errorMessage = validationError
      return
    }
    
    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
    do {
            try await loginUseCase.execute(email: trimmedEmail, password: password)
      appState.isAuthenticated = true
    } catch {
      errorMessage = AuthErrorMapper.userFriendlyMessage(for: error)
    }
  }
  
  func validate() -> String? {
    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
    
        guard !trimmedEmail.isEmpty, !password.isEmpty else {
            return L10n.Validation.fillAll
        }
        
        guard trimmedEmail.isValidEmail else {
            return L10n.Validation.invalidEmail
        }
        
        guard password.count >= 6 else {
            return L10n.Validation.passwordLength
        }
    
    return nil
  }
}
