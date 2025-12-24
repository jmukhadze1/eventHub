//
//  LoginRequest.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let accessToken: String?
    let token: String?
    let userId: Int?
}
struct BackendErrorResponse: Decodable {
    let message: String?
    let statusCode: Int?
}
