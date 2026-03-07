//
//  AppDateRow.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import SwiftUI

struct AppDateRow: View {

    var text: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: L10n.Icon.calendar)
                    .foregroundColor(.gray)

                Text(text)
                    .foregroundColor(.black)

                Spacer()

                Image(systemName: L10n.Icon.chevronRight)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}
