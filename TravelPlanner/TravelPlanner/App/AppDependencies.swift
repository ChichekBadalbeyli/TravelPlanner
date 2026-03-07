import Foundation
import SwiftUI
import SwiftData

struct AppDependencies {
    let authService: AuthServicing
    let networkService: NetworkService
    let makeTripsRepository: (ModelContext) -> TripsRepository
    let makePlacesRepository: () -> PlacesRepository
    let makeWeatherRepository: () -> WeatherRepository
}

extension AppDependencies {
    static let live = AppDependencies(
        authService: AuthService(),
        networkService: DefaultNetworkService(),
        makeTripsRepository: { DefaultTripsRepository(context: $0) },
        makePlacesRepository: { DefaultPlacesRepository(network: DefaultNetworkService()) },
        makeWeatherRepository: { DefaultWeatherRepository(network: DefaultNetworkService()) }
    )
}

private struct AppDependenciesKey: EnvironmentKey {
    static let defaultValue: AppDependencies = .live
}

extension EnvironmentValues {
    var appDependencies: AppDependencies {
        get { self[AppDependenciesKey.self] }
        set { self[AppDependenciesKey.self] = newValue }
    }
}

