//
//  CreatePlanView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI

struct CreatePlanView: View {

    @StateObject private var viewModel = CreatePlanViewModel()

    var body: some View {
        ZStack {
            AppGradient()
            VStack() {
                AppCard {
                    VStack(spacing: 30) {
                        Text("Create Plan")
                            .font(.largeTitle.bold())
                            .foregroundColor(.black)
                        VStack(spacing: 20) {
                            AppSearchField(
                                placeholder: "Search city",
                                text: $viewModel.city
                            )
                            AppDateRow(
                                text: dateRangeText
                            ) {
                                viewModel.isDatePickerPresented = true
                            }
                            AppPrimaryButton(title: "Continue") {
                                viewModel.navigateNext = true
                            }
                            .disabled(!viewModel.isFormValid)
                            .opacity(viewModel.isFormValid ? 1 : 0.5)
                        }
                    }
                }
                .padding(.horizontal)
                .sheet(isPresented: $viewModel.isDatePickerPresented) {
                    datePickerSheet
                }
                .navigationDestination(isPresented: $viewModel.navigateNext) {
                    CityView(
                        city: viewModel.city,
                        startDate: viewModel.startDate,
                        endDate: viewModel.endDate
                    )
                }
            }
        }
    }
    
    private var dateRangeText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return "\(formatter.string(from: viewModel.startDate)) - \(formatter.string(from: viewModel.endDate))"
    }

    private var datePickerSheet: some View {
        VStack(spacing: 20) {
            DatePicker("Start Date",
                       selection: $viewModel.startDate,
                       displayedComponents: .date)

            DatePicker("End Date",
                       selection: $viewModel.endDate,
                       in: viewModel.startDate...,
                       displayedComponents: .date)

            AppPrimaryButton(title: "Save Dates") {
                viewModel.isDatePickerPresented = false
            }
        }
        .padding()
        .presentationDetents([.medium])
    }
}
