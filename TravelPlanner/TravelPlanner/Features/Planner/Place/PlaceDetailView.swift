//
//  PlaceDetailView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/28/26.
//

import Foundation
import SwiftUI
import MapKit

struct PlaceDetailView: View {
    
    let place: Place
    
    @StateObject private var viewModel: PlaceDetailViewModel
    @State private var region: MKCoordinateRegion
    
    init(place: Place, viewModel: PlaceDetailViewModel) {
        self.place = place
        _viewModel = StateObject(wrappedValue: viewModel)
        _region = State(
            initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: place.lat,
                    longitude: place.lon
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01
                )
            )
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(place.name)
                    .font(.title2.bold())
                Map(coordinateRegion: $region, annotationItems: [place]) { item in
                    MapMarker(
                        coordinate: CLLocationCoordinate2D(
                            latitude: item.lat,
                            longitude: item.lon
                        )
                    )
                }
                .frame(height: 500)
                .cornerRadius(20)
                if viewModel.isLoading {
                    ProgressView()
                }
                detailInfo
            }
            .padding()
            }
            .onAppear {
                viewModel.loadDetails(for: place.id)
            }
        }
    
    var detailInfo: some View {
        VStack(spacing: 16) {
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            if let details = viewModel.details {
                
                if let address = details.formatted {
                    infoRow(icon: Localization.Icon.mappinEllipse, text: address)
                }
                
                if let website = details.website {
                    infoRow(icon: Localization.Icon.globe, text: website)
                }
                
                if let phone = details.phone {
                    infoRow(icon: Localization.Icon.phoneFill, text: phone)
                }
                
                if let hours = details.openingHours {
                    infoRow(icon: Localization.Icon.clockFill, text: hours)
                }
            }
        }
    }
    
    func infoRow(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            Text(text)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
