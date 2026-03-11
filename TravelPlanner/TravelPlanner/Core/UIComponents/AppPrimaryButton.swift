//
//  AppPrimaryButton.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import SwiftUI

struct AppPrimaryButton: View {

    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}
