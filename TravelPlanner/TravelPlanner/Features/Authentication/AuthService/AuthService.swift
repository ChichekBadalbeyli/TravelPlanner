//
//  AuthService.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    func register(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func login(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail:  email, password: password)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func isUserLoggedIn() -> Bool {
        Auth.auth().currentUser != nil
    }
}
