//
//  Untitled.swift
//  eventHub
//
//  Created by David on 20.12.25.
//

import Foundation
import Combine

@MainActor
final class SignInViewModel: ObservableObject {
    
    // MARK: Input
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var rememberMe: Bool = false
    
    // MARK: UI State
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: Callbacks
    let onSignInSuccess: () -> Void
    let onSignUp: () -> Void
    let onForgotPassword: () -> Void
    
    init(
        onSignInSuccess: @escaping () -> Void,
        onSignUp: @escaping () -> Void,
        onForgotPassword: @escaping () -> Void
    ) {
        self.onSignInSuccess = onSignInSuccess
        self.onSignUp = onSignUp
        self.onForgotPassword = onForgotPassword
    }
    
    // MARK: - Actions
    func signInTapped() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Fill in your Email and Password."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            await signIn()
        }
    }
    
    private func signIn() async {
        let body = LoginRequest(email: email, password: password)
        
        do {
            let response: LoginResponse = try await NetworkClient.shared.post(
                "auth/login",
                body: body,
                authorized: false
            )
            
            if let token = response.accessToken ?? response.token {
                AuthStorage.shared.accessToken = token
            }
            
            isLoading = false
            onSignInSuccess()
            
        } catch let apiError as APIError {
            isLoading = false
            
            switch apiError {
            case .serverError(let status, let rawMessage):
                
                if let rawMessage,
                   let data = rawMessage.data(using: .utf8),
                   let backendError = try? JSONDecoder().decode(BackendErrorResponse.self, from: data),
                   let backendMessage = backendError.message,
                   !backendMessage.isEmpty {
                    
                    errorMessage = backendMessage
                    
                } else if status == 401 {
                    errorMessage = "Invalid email or password."
                } else {
                    errorMessage = "Server error (\(status)). Please try again."
                }
                
            default:
                errorMessage = "Unexpected error. Please try again."
            }
            
        } catch {
            isLoading = false
            errorMessage = "Something went wrong. Please try again."
        }
    }
}
