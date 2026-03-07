import Foundation

protocol WeatherRepository {
    func geocode(city: String) async throws -> GeocodeResult
    func fetchDailyForecast(
        latitude: Double,
        longitude: Double,
        startDate: Date,
        endDate: Date
    ) async throws -> [WeatherDay]
}

struct DefaultWeatherRepository: WeatherRepository {
    let network: NetworkService

    init(network: NetworkService) {
        self.network = network
    }

    func geocode(city: String) async throws -> GeocodeResult {
        let geo: GeocodeResponse = try await network.request(
            OpenMeteoEndpoints.geocode(city: city)
        )
        guard let location = geo.results?.first else {
            throw NetworkError.noData
        }
        return location
    }

    func fetchDailyForecast(
        latitude: Double,
        longitude: Double,
        startDate: Date,
        endDate: Date
    ) async throws -> [WeatherDay] {
        let start = DateFormatters.isoDay.string(from: startDate)
        let end = DateFormatters.isoDay.string(from: endDate)

        let forecast: ForecastResponse = try await network.request(
            OpenMeteoEndpoints.forecast(
                latitude: latitude,
                longitude: longitude,
                startDate: start,
                endDate: end
            )
        )

        return zip(
            forecast.daily.time,
            zip(forecast.daily.temperature_2m_max, forecast.daily.weathercode)
        ).map { dateString, values in
            let (temp, code) = values
            let weekday = DefaultWeatherRepository.formattedWeekday(fromISODate: dateString)
            return WeatherDay(day: weekday, temperature: Int(temp), weatherCode: code)
        }
    }

    private static func formattedWeekday(fromISODate string: String) -> String {
        guard let date = DateFormatters.isoDay.date(from: string) else {
            return string
        }
        return DateFormatters.shortWeekday.string(from: date)
    }
}

