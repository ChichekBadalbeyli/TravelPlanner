# ✈️ TravelPlanner

TravelPlanner is an iOS application that helps users plan trips, explore attractions, check weather forecasts, and create personalized travel itineraries.

The app allows users to generate a travel plan based on selected attractions and save trips for later viewing.

---

## 📱 Features

- 🔐 User authentication with Firebase
- 🌍 Search for cities and attractions
- ☀️ Weather forecast for travel dates
- 🗺 Map view with location markers
- 📍 Attraction details (address, website, phone)
- 🗓 Generate a trip itinerary
- 💾 Save trips locally using SwiftData
- 👤 Trips are stored per user
- 🗑 Delete saved trips

---

## 🏗 Architecture

The project follows **MVVM architecture**.

---

## 🛠 Technologies

- Swift
- SwiftUI
- SwiftData
- Firebase Authentication
- MapKit

---

## 🔑 Setup (API keys)

This project uses Geoapify for places/attractions.

- **GEOAPIFY_API_KEY**: set it as an Xcode Build Setting (User-Defined) named `GEOAPIFY_API_KEY` for the `TravelPlanner` target (Debug/Release).

The key is referenced from `Info.plist` as `$(GEOAPIFY_API_KEY)` and read at runtime via `AppConfig.geoapifyApiKey`.

## 🔥 Setup (Firebase)

Firebase config (`GoogleService-Info.plist`) is intentionally **not tracked by git**.

- Download it from Firebase Console for your iOS app
- Place it at `TravelPlanner/GoogleService-Info.plist`
- Ensure it’s added to the Xcode project (it’s already referenced in `project.pbxproj`; locally the file just needs to exist)
