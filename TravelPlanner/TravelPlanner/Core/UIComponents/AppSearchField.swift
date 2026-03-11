//
//  AppSearchField.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import SwiftUI

struct AppSearchField: View {

    var placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: L10n.Icon.magnifyingglass)
                .foregroundColor(.gray)

            TextField(placeholder, text: $text)
            .textContentType(.addressCity)
                .autocorrectionDisabled()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
