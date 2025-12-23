//
//  AuthService.swift
//  eventHub
//
//  Created by MacBook on 12/23/25.
//

import Foundation

enum AuthError: Error {
    case emailAlreadyExists
    case invalidOTP
    case unknown
}

protocol AuthService {
    func register(
        request: RegisterRequest,
        completion: @escaping (Result<Void, AuthError>) -> Void
    )
}


    // MockAuthService

final class MockAuthService: AuthService {

    func register(
        request: RegisterRequest,
        completion: @escaping (Result<Void, AuthError>) -> Void
    ) {
        // Fake network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(()))
        }
    }
}
