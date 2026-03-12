# ✈️ TravelPlanner

TravelPlanner is an iOS application that helps users plan trips, explore attractions, check weather forecasts, and generate travel itineraries.

Users can search for a city, select attractions, generate a travel plan for their trip dates, and save trips for later viewing.

---

## 📱 Features

- Firebase Authentication (login & registration)
- Search cities and plan trips
- Weather forecast for travel dates
- Explore city attractions
- Map with attraction locations
- Attraction details (address, website, phone, opening hours)
- Select attractions for your trip
- Automatically generate a travel itinerary
- Save trips locally using SwiftData
- Trips stored per user
- View saved trips
- Delete saved trips

---

## 🏗 Architecture

The project follows a modular and scalable architecture.

Patterns used:

- MVVM (Model–View–ViewModel)
- Coordinator pattern for navigation
- Repository layer for data access
- UseCase layer for business logic
- Dependency Injection via SwiftUI Environment

Layer structure:

View  
↓  
ViewModel  
↓  
UseCase  
↓  
Repository  
↓  
Network / Storage  

This separation keeps the codebase maintainable, scalable, and testable.

---

## 🛠 Technologies

- Swift
- SwiftUI
- SwiftData
- Firebase Authentication
- MapKit
- SwiftGen
- Tuist

---

## 🌐 APIs

The application uses external APIs to retrieve travel information.

### Open-Meteo API
Used for retrieving weather forecasts for selected travel dates.

https://open-meteo.com/

### Geoapify API
Used for retrieving attractions and place details.

https://www.geoapify.com/

---

## 🔐 API Keys

API keys are not hardcoded in the source code.

They are stored in **Info.plist** and accessed through the `AppConfig` helper.

Example key:

GEOAPIFY_API_KEY

---

## 🧪 Testing

The project includes unit tests.

Tested components include:

- LoginViewModel
- RegistrationViewModel
- Email validation logic

Tests verify:

- form validation
- password rules
- email formatting

---

## 📦 Project Structure

```
TravelPlanner
│
├── App
├── Coordinators
├── Views
├── ViewModels
├── UseCases
├── Repositories
├── Networking
├── Models
├── Resources
└── Tests
```

---

## 📱 Requirements

- iOS 17+
- Xcode 15+
- Swift 5.9+

---

## 🚀 Future Improvements

Possible improvements:

- Route optimization between attractions
- Offline trip storage
- Photo previews for attractions
- Better itinerary generation algorithm
- Map navigation between places

---

## 👩‍💻 Author

Created by **Chichak Badalbayli**
