//
//  ProfileView.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import SwiftUI
import FirebaseAuth
import SwiftData

struct ProfileView: View {
    
    @Query private var trips: [TripEntity]
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 32) {
            profileHeader
            userInfo
            Spacer()
            logoutButton
        }
        .padding()
        .navigationTitle("Profile")
    }
    
    private var tripsCount: String {
        "\(trips.count)"
    }
    
    private var profileHeader: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Text(userEmail)
                .font(.headline)
        }
    }
    
    private var userInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            infoRow(icon: "envelope", title: "Email", value: userEmail)
            infoRow(icon: "airplane", title: "Trips", value: tripsCount)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
    
    private func infoRow(icon: String, title: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
    
    private var logoutButton: some View {
        Button {
            appState.logout()
        } label: {
            Text("Log Out")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(16)
        }
    }
    
    private var userEmail: String {
        Auth.auth().currentUser?.email ?? "Unknown"
    }
}
