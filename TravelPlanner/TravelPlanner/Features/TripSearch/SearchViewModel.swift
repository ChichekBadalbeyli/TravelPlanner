//
//  CreatePlanViewModel.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {

    @Published var city: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var isDatePickerPresented = false

    var isFormValid: Bool {
        !city.trimmingCharacters(in: .whitespaces).isEmpty &&
        endDate >= startDate
    }
}
