//
//  AppCard.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import SwiftUI

struct AppCard<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(radius: 20)
    }
}
