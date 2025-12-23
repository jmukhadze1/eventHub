//
//  Untitled.swift
//  eventHub
//
//  Created by David on 20.12.25.
//

import Foundation
import Combine

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

    func signInTapped() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Fill in your Email and Password."
            return
        }

        isLoading = true
        errorMessage = nil

        // MOCK 
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.isLoading = false
            self.onSignInSuccess()
        }
    }
}
