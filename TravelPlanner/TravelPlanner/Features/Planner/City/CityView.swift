//
//  CityView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation
import SwiftUI

struct CityView: View {
    
    @StateObject private var viewModel = CityViewModel()
    @Environment(\.dismiss) private var dismiss
    
    let city: String
    let startDate: Date
    let endDate: Date
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    Text("\(formatted(startDate)) - \(formatted(endDate))")
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
        .navigationTitle(city)
        .onAppear {
            viewModel.load(
                city: city,
                startDate: startDate,
                endDate: endDate
            )
        }
        .sheet(item: $viewModel.selectedPlace) { place in
           PlaceDetailView(place: place)
        }
        .alert("", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text(viewModel.errorMessage ?? "The information could not be loaded. Please check city name and try again.")
        }
        .navigationDestination(isPresented: $viewModel.navigateToPlan) {
            if let plan = viewModel.generatedPlan {
                TripPlanView(
                    isSavedTrip: false,
                    city: city,
                    startDate: startDate,
                    endDate: endDate,
                    plan: plan
                )
            }
        }
    }
    
    var weatherSection: some View {
        VStack(alignment: .leading) {
            Text("Weather")
                .font(.headline)
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.weather) { day in
                            WeatherCard(day: day)
                        }
                    }
                }
            }
        }
    }
    
    var attractionsSection: some View {
        VStack(alignment: .leading) {
            Text("Top Attractions")
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
        } label: {
            Text("Create Plan")
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
