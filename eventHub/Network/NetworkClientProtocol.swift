//
//  NetworkClientProtocol.swift
//  eventHub
//
//  Created by David on 24.12.25.
//

import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable, Body: Encodable>(
        path: String,
        method: HTTPMethod,
        query: [String: CustomStringConvertible]?,
        body: Body,
        authorized: Bool
    ) async throws -> T

    func request<T: Decodable>(
        path: String,
        method: HTTPMethod,
        query: [String: CustomStringConvertible]?,
        authorized: Bool
    ) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {

    static let shared = NetworkClient()

    private let session = URLSession.shared
    private let baseURL = URL(string: "http://35.158.140.93/api")!

    private init() {}

    // MARK: - Request with Body (POST, PUT, PATCH)
    func request<T: Decodable, Body: Encodable>(
        path: String,
        method: HTTPMethod,
        query: [String : CustomStringConvertible]? = nil,
        body: Body,
        authorized: Bool = false
    ) async throws -> T {

        var urlComponents = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )

        if let query = query {
            urlComponents?.queryItems = query.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }

        guard let url = urlComponents?.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if authorized, let token = AuthStorage.shared.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        request.httpBody = try JSONEncoder().encode(body)

        return try await perform(request)
    }

    // MARK: - Request without Body
    func request<T: Decodable>(
        path: String,
        method: HTTPMethod = .get,
        query: [String : CustomStringConvertible]? = nil,
        authorized: Bool = false
    ) async throws -> T {

        var urlComponents = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )

        if let query = query {
            urlComponents?.queryItems = query.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }

        guard let url = urlComponents?.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if authorized, let token = AuthStorage.shared.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return try await perform(request)
    }

    // MARK: - Shared execution
    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)

            guard let http = response as? HTTPURLResponse else {
                throw APIError.noData
            }

            guard (200..<300).contains(http.statusCode) else {
                let message = String(data: data, encoding: .utf8)
                throw APIError.serverError(statusCode: http.statusCode, message: message)
            }

            guard !data.isEmpty else {
                throw APIError.noData
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(T.self, from: data)

        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.unknown(error)
        }
    }
}
