//
//  AppGradient.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import SwiftUI

struct AppGradient: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color.blue.opacity(0.6),
                Color.gray.opacity(0.2)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
