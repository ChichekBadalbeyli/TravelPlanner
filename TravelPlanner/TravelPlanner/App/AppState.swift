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
}
