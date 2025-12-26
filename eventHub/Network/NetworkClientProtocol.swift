//
//  NetworkClientProtocol.swift
//  eventHub
//
//  Created by David on 24.12.25.
//

import Foundation

final class NetworkClient {

    static let shared = NetworkClient()

    private let baseURL = URL(string: "http://35.158.140.93/api")!
    private init() {}

    // MARK: - GET
    func get<Response: Decodable>(
        _ path: String,
        query: [String: CustomStringConvertible]? = nil,
        authorized: Bool = false
    ) async throws -> Response {

        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )

        if let query = query {
            components?.queryItems = query.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }

        guard let url = components?.url else { throw APIError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        if authorized, let token = AuthStorage.shared.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return try await send(request)
    }

    // MARK: - POST
    func post<Response: Decodable, Body: Encodable>(
        _ path: String,
        body: Body,
        authorized: Bool = false
    ) async throws -> Response {

        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        if authorized, let token = AuthStorage.shared.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return try await send(request)
    }

    private func send<Response: Decodable>(_ request: URLRequest) async throws -> Response {

        let (data, response) = try await URLSession.shared.data(for: request)

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
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: data)
    }
}
// MARK: - POST without decoding (for text/plain responses like OTP)

extension NetworkClient {
    func postNoResponse<Body: Encodable>(
        _ path: String,
        body: Body,
        authorized: Bool = false
    ) async throws {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        if authorized, let token = AuthStorage.shared.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.noData
        }

        guard (200..<300).contains(http.statusCode) else {
            let message = String(data: data, encoding: .utf8)
            throw APIError.serverError(statusCode: http.statusCode, message: message)
        }

    }
}
extension NetworkClient {

    func fetchEventsPage(
        page: Int = 1,
        pageSize: Int = 10
    ) async throws -> EventsPageResponse {

        return try await get(
            "events",
            query: [
                "Page": page,
                "PageSize": pageSize
            ],
            authorized: true  
        )
    }
}

