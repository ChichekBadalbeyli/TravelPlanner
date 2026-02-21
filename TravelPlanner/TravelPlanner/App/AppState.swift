//
//  AppState.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation
import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    private let authService = AuthService()
    
    init() {
        isAuthenticated = authService.isUserLoggedIn()
    }
    
    func logout() {
        try? authService.logout()
        isAuthenticated = false
    }
}
