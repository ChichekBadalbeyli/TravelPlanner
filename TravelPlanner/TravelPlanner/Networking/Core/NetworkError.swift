//
//  NetworkError.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case encodingError
    case serverError(statusCode: Int)
    case unknown(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "The server response contained no data."
        case .decodingError:
            return "The server response could not be decoded."
        case .encodingError:
            return "The request body could not be encoded."
        case .serverError(let statusCode):
            return "The server responded with status code \(statusCode)."
        case .unknown:
            return "An unknown networking error occurred."
        }
    }
}
