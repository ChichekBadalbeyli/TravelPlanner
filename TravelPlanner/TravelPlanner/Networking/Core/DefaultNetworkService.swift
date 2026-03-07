//
//  DefaultNetworkService.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

final class DefaultNetworkService: NetworkService {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let requestResult = endpoint.makeRequest()

        switch requestResult {
        case .success(let urlRequest):
            do {
                let (data, response) = try await session.data(for: urlRequest)

                if let httpResponse = response as? HTTPURLResponse {
                    guard (200...299).contains(httpResponse.statusCode) else {
                        throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                    }
                }

                guard !data.isEmpty else {
                    throw NetworkError.noData
                }

                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw NetworkError.decodingError
                }
            } catch let error as NetworkError {
                throw error
            } catch {
                throw NetworkError.unknown(error)
            }

        case .failure(let error):
            throw error
        }
    }
}
