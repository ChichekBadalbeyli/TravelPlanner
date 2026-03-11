//
//  AuthService.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import FirebaseAuth
import FirebaseCore

protocol AuthServicing {
    func register(email: String, password: String) async throws
    func login(email: String, password: String) async throws
    func logout() throws
    func isUserLoggedIn() -> Bool
}

final class AuthService: AuthServicing {
    
    func register(email: String, password: String) async throws {
        guard FirebaseApp.app() != nil else { throw AuthServiceError.firebaseNotConfigured }
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func login(email: String, password: String) async throws {
        guard FirebaseApp.app() != nil else { throw AuthServiceError.firebaseNotConfigured }
        try await Auth.auth().signIn(withEmail:  email, password: password)
    }
    
    func logout() throws {
        guard FirebaseApp.app() != nil else { throw AuthServiceError.firebaseNotConfigured }
        try Auth.auth().signOut()
    }
    
    func isUserLoggedIn() -> Bool {
        guard FirebaseApp.app() != nil else { return false }
        return Auth.auth().currentUser != nil
    }
}

enum AuthServiceError: LocalizedError {
    case firebaseNotConfigured

    var errorDescription: String? {
        switch self {
        case .firebaseNotConfigured:
            return "Firebase is not configured. Add GoogleService-Info.plist and rebuild."
        }
    }
}
