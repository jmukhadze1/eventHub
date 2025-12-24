//
//  APIError.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    case serverError(statusCode: Int, message: String?)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "Empty response"
        case .decodingFailed:
            return "We could not read"
        case .serverError(let code, let message):
            return "Server Error (\(code)): \(message ?? "Unknown Error")"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
