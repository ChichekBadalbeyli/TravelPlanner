//
//  AppTextField.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import SwiftUI

struct AppTextField: View {

    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(.white)
            .cornerRadius(12)
    }
}
