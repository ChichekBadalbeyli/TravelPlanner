//
//  AppLoadingOverlay.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import SwiftUI

struct AppLoadingOverlay: ViewModifier {
    let isLoading: Bool

    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    ZStack {
                        Color.black.opacity(0.15).ignoresSafeArea()
                        ProgressView()
                            .padding(16)
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                    }
                }
            }
    }
}

extension View {
    func appLoadingOverlay(_ isLoading: Bool) -> some View {
        modifier(AppLoadingOverlay(isLoading: isLoading))
    }
}

