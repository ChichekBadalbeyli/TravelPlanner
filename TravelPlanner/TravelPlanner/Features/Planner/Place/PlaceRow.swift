//
//  PlaceRow.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation
import SwiftUI

struct PlaceRow: View {
    
    let place: Place
    let onAdd: () -> Void
    let onSelect: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(place.name)
                    .font(.headline)
            }
            Spacer()
            Button(action: onAdd) {
                Image(systemName: place.isAdded ? Localization.Icon.checkmarkCircleFill : Localization.Icon.circle)
                    .font(.system(size: 22))
                    .foregroundColor(place.isAdded ? .yellow : .gray)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5)
        .onTapGesture {
            onSelect()
        }
    }
}

