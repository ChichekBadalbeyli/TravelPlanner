//
//  CreatePlanView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI

struct CreatePlanView: View {

    @StateObject private var viewModel = CreatePlanViewModel()
    @StateObject private var coordinator = CreatePlanFlowCoordinator()
    @Environment(\.appDependencies) private var dependencies

    var body: some View {
        ZStack {
            AppGradient()
            VStack {
                AppCard {
                    VStack(spacing: 30) {
                        Text(L10n.CreatePlan.title)
                            .font(.largeTitle.bold())
                            .foregroundColor(.black)
                        VStack(spacing: 20) {
                            AppSearchField(
                                placeholder: L10n.CreatePlan.searchCity,
                                text: $viewModel.city
                            )
                            AppDateRow(
                                text: dateRangeText
                            ) {
                                viewModel.isDatePickerPresented = true
                            }
                            AppPrimaryButton(title: L10n.CreatePlan.continueButton) {
                                coordinator.citySelection = CitySelection(
                                    city: viewModel.city,
                                    startDate: viewModel.startDate,
                                    endDate: viewModel.endDate
                                )
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
            }
        }
        .navigationDestination(item: $coordinator.citySelection) { selection in
            CityView(
                city: selection.city,
                startDate: selection.startDate,
                endDate: selection.endDate,
                viewModel: CityViewModel(
                    fetchCityDataUseCase: DefaultFetchCityDataUseCase(
                        weatherRepository: dependencies.makeWeatherRepository(),
                        placesRepository: dependencies.makePlacesRepository()
                    ),
                    generateTripPlanUseCase: DefaultGenerateTripPlanUseCase()
                )
            )
            .environmentObject(coordinator)
        }
    }
    
    private var dateRangeText: String {
        let start = DateFormatters.medium.string(from: viewModel.startDate)
        let end = DateFormatters.medium.string(from: viewModel.endDate)
        return String(format: L10n.City.dateRangeFormat, start, end)
    }

    private var datePickerSheet: some View {
        VStack(spacing: 20) {
            DatePicker(L10n.DatePicker.startDate,
                       selection: $viewModel.startDate,
                       displayedComponents: .date)

            DatePicker(L10n.DatePicker.endDate,
                       selection: $viewModel.endDate,
                       in: viewModel.startDate...,
                       displayedComponents: .date)

            AppPrimaryButton(title: L10n.CreatePlan.saveDates) {
                viewModel.isDatePickerPresented = false
            }
        }
        .padding()
        .presentationDetents([.medium])
    }
}
