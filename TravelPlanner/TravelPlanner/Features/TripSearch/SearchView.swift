//
//  CreatePlanView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI

struct SearchView: View {

    @StateObject private var viewModel = SearchViewModel()
    @StateObject private var coordinator = SearchFlowCoordinator()
    @Environment(\.appDependencies) private var dependencies
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            AppGradient()
            VStack {
                AppCard {
                    VStack(spacing: 30) {
                        Text(Localization.CreatePlan.title)
                            .font(.largeTitle.bold())
                            .foregroundColor(.black)
                        VStack(spacing: 20) {
                            AppSearchField(
                                placeholder: Localization.CreatePlan.searchCity,
                                text: $viewModel.city
                            )
                            AppDateRow(
                                text: dateRangeText
                            ) {
                                viewModel.isDatePickerPresented = true
                            }
                            AppPrimaryButton(title: Localization.CreatePlan.continueButton) {
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
        .onChange(of: appState.selectedTab) {
            if appState.selectedTab == 0 {
                coordinator.planDestination = nil
                coordinator.citySelection = nil
                viewModel.city = ""
                viewModel.startDate = Date()
                viewModel.endDate = Date()
            }
        }
    }
    
    private var dateRangeText: String {
        let start = DateFormatters.medium.string(from: viewModel.startDate)
        let end = DateFormatters.medium.string(from: viewModel.endDate)
        return String(format: Localization.City.dateRangeFormat, start, end)
    }

    private var datePickerSheet: some View {
        VStack(spacing: 20) {
            DatePicker(Localization.DatePicker.startDate,
                       selection: $viewModel.startDate,
                       displayedComponents: .date)

            DatePicker(Localization.DatePicker.endDate,
                       selection: $viewModel.endDate,
                       in: viewModel.startDate...,
                       displayedComponents: .date)

            AppPrimaryButton(title: Localization.CreatePlan.saveDates) {
                viewModel.isDatePickerPresented = false
            }
        }
        .padding()
        .presentationDetents([.medium])
    }
}
