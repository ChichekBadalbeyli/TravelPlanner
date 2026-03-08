# ✈️ TravelPlanner

TravelPlanner is an iOS app that helps users plan trips, explore attractions, check weather forecasts, and create travel itineraries.

Users can select attractions in a city, generate a trip plan, and save trips for later viewing.

---

## 📱 Features

- Firebase Authentication
- Search cities and attractions
- Weather forecast for travel dates
- Map with attraction locations
- Attraction details (address, website, phone)
- Generate travel itinerary
- Save trips locally using SwiftData
- Trips stored per user
- Delete saved trips

---

## 🏗 Architecture

- MVVM
- Coordinator pattern for navigation
- Repository + UseCase layers

---

## 🛠 Technologies

- Swift
- SwiftUI
- SwiftData
- Firebase Authentication
- MapKit
- SwiftGen

---

## 🔐 API Keys

API keys are stored in **Info.plist** and accessed through **AppConfig** instead of being hardcoded in the code.

---

## 🌐 APIs

- Open-Meteo API — weather data
- Geoapify API — attractions and place details
