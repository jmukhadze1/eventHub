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

    func sendOtp(
        phoneNumber: String,
        completion: @escaping (Result<Void, AuthError>) -> Void
    )

    func verifyOtp(
        phoneNumber: String,
        otp: String,
        completion: @escaping (Result<Void, AuthError>) -> Void
    )
}

final class RealAuthService: AuthService {

    func register(
        request: RegisterRequest,
        completion: @escaping (Result<Void, AuthError>) -> Void
    ) {
        Task {
            do {
                let _: BasicMessageResponse = try await NetworkClient.shared.post(
                    "auth/register",
                    body: request,
                    authorized: false
                )

                DispatchQueue.main.async {
                    completion(.success(()))
                }

            } catch let apiError as APIError {
                DispatchQueue.main.async {
                    completion(.failure(self.mapRegisterError(apiError)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.unknown))
                }
            }
        }
    }

    func sendOtp(
        phoneNumber: String,
        completion: @escaping (Result<Void, AuthError>) -> Void
    ) {
        Task {
            do {
                let body = SendOtpRequest(phoneNumber: phoneNumber)
                // აქაც message გვკიდია
                let _: BasicMessageResponse = try await NetworkClient.shared.post(
                    "auth/send-otp",
                    body: body,
                    authorized: false
                )

                DispatchQueue.main.async {
                    completion(.success(()))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.unknown))
                }
            }
        }
    }

    func verifyOtp(
        phoneNumber: String,
        otp: String,
        completion: @escaping (Result<Void, AuthError>) -> Void
    ) {
        Task {
            do {
                let body = VerifyOtpRequest(phoneNumber: phoneNumber, otp: otp)
                let _: BasicMessageResponse = try await NetworkClient.shared.post(
                    "auth/verify-otp",
                    body: body,
                    authorized: false
                )

                DispatchQueue.main.async {
                    completion(.success(()))
                }

            } catch let apiError as APIError {
                DispatchQueue.main.async {
                    completion(.failure(self.mapVerifyError(apiError)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.unknown))
                }
            }
        }
    }

    // MARK: - Error mapping

    private func mapRegisterError(_ error: APIError) -> AuthError {
        if case let .serverError(status, _) = error,
           status == 409 {
            return .emailAlreadyExists
        }
        return .unknown
    }

    private func mapVerifyError(_ error: APIError) -> AuthError {
        if case let .serverError(status, _) = error,
           status == 400 || status == 401 {
            return .invalidOTP
        }
        return .unknown
    }
}

// MARK: - MockAuthService (შეინახე previews/ტესტებისთვის)

final class MockAuthService: AuthService {

    func register(
        request: RegisterRequest,
        completion: @escaping (Result<Void, AuthError>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(()))
        }
    }

    func sendOtp(
        phoneNumber: String,
        completion: @escaping (Result<Void, AuthError>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(.success(()))
        }
    }

    func verifyOtp(
        phoneNumber: String,
        otp: String,
        completion: @escaping (Result<Void, AuthError>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(.success(()))
        }
    }
}
