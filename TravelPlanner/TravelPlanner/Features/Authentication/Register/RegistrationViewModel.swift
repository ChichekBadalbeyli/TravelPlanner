//
//  RegisterViewModel.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI
import Combine

@MainActor
final class RegistrationViewModel: ObservableObject {
  
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  @Published var errorMessage: String?
  
  
  var isFormValid: Bool {
    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmedEmail.isValidEmail &&
    password.count >= 6 &&
    confirmPassword.count >= 6
  }
  
  private let authService: AuthServicing
  
  init(authService: AuthServicing = AuthService()) {
    self.authService = authService
  }
  
  func register(appState: AppState) async {
    errorMessage = nil
    
    if let validationError = validate() {
      errorMessage = validationError
      return
    }
    
    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
    do {
      try await authService.register(email: trimmedEmail, password: password)
      appState.isAuthenticated = true
    } catch {
      errorMessage = AuthErrorMapper.userFriendlyMessage(for: error)
    }
  }
  
  func validate() -> String? {
    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
    
    guard !trimmedEmail.isEmpty,
          !password.isEmpty,
          !confirmPassword.isEmpty else {
      return "Please fill in all fields."
    }
    
    guard trimmedEmail.isValidEmail else {
      return "Please enter a valid email address."
    }
    
    guard password.count >= 6 else {
      return "Password must be at least 6 characters."
    }
    
    guard password == confirmPassword else {
      return "Passwords do not match."
    }
    
    return nil
  }
}
