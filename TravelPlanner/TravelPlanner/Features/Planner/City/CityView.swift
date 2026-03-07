//
//  CityView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation
import SwiftUI

struct CityView: View {
    
    @StateObject private var viewModel: CityViewModel
    @Environment(\.appDependencies) private var dependencies
    @EnvironmentObject private var coordinator: CreatePlanFlowCoordinator
    @Environment(\.dismiss) private var dismiss
    
    let city: String
    let startDate: Date
    let endDate: Date

    init(
        city: String,
        startDate: Date,
        endDate: Date,
        viewModel: CityViewModel
    ) {
        self.city = city
        self.startDate = startDate
        self.endDate = endDate
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    Text(String(format: L10n.City.dateRangeFormat, formatted(startDate), formatted(endDate)))
                        .foregroundColor(.gray)
                    weatherSection
                    attractionsSection
                }
                .padding()
            }
            .safeAreaInset(edge: .bottom) {
                createPlanButton
                    .padding()
            }
        }
        .appLoadingOverlay(viewModel.isLoading)
        .navigationTitle(city)
        .onAppear {
            viewModel.load(
                city: city,
                startDate: startDate,
                endDate: endDate
            )
        }
        .sheet(item: $viewModel.selectedPlace) { place in
           PlaceDetailView(
               place: place,
               viewModel: PlaceDetailViewModel(
                   fetchPlaceDetailsUseCase: DefaultFetchPlaceDetailsUseCase(
                       placesRepository: dependencies.makePlacesRepository()
                   )
               )
           )
        }
        .alert("", isPresented: $viewModel.showError) {
            Button(L10n.Common.ok, role: .cancel) {
                dismiss()
            }
        } message: {
            Text(viewModel.errorMessage ?? L10n.City.loadError)
        }
        .navigationDestination(item: $coordinator.planDestination) { destination in
            TripPlanView(
                isSavedTrip: destination.isSavedTrip,
                city: destination.city,
                startDate: destination.startDate,
                endDate: destination.endDate,
                plan: destination.plan
            )
        }
    }
    
    var weatherSection: some View {
        VStack(alignment: .leading) {
            Text(L10n.City.weather)
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.weather) { day in
                        WeatherCard(day: day)
                    }
                }
            }
        }
    }
    
    var attractionsSection: some View {
        VStack(alignment: .leading) {
            Text(L10n.City.topAttractions)
                .font(.headline)
            
            ForEach(viewModel.places) { place in
                PlaceRow(
                    place: place,
                    onAdd: {
                        viewModel.togglePlace(place)
                    },
                    onSelect: {
                        viewModel.selectedPlace = place
                    }
                )
            }
        }
    }
    
    var createPlanButton: some View {
        Button {
            viewModel.generatePlan(
                startDate: startDate,
                endDate: endDate
            )
            if let plan = viewModel.generatedPlan {
                coordinator.planDestination = PlanDestination(
                    isSavedTrip: false,
                    city: city,
                    startDate: startDate,
                    endDate: endDate,
                    plan: plan
                )
            }
        } label: {
            Text(L10n.CreatePlan.createPlanButton)
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.hasSelectedPlaces ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(16)
        }
        .disabled(!viewModel.hasSelectedPlaces)
    }
    
    func formatted(_ date: Date) -> String {
        DateFormatters.medium.string(from: date)
    }
}
