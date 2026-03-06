//
//  WeatherCard.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation
import SwiftUI

struct WeatherCard: View {
    
    let day: WeatherDay
    
    var body: some View {
        let weatherType = WeatherType.from(code: day.weatherCode)
        
        VStack(spacing: 8) {
            
            Text(day.day)
                .font(.caption)
                .foregroundColor(.gray)
            
            Image(systemName: weatherType.icon)
                .foregroundColor(.orange)
                .font(.title2)
            
            Text("\(day.temperature)°")
                .font(.headline)
        }
        .padding()
        .frame(width: 80)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}
