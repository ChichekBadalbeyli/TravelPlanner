//
//  AppSecureField.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import SwiftUI

struct AppSecureField: View {

    var placeholder: String
    @Binding var text: String

    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .background(.white.opacity(0.9))
            .cornerRadius(12)
    }
}
