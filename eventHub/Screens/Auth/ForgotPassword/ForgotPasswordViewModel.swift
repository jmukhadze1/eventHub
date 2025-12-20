//
//  ForgotPasswordViewModel.swift
//  eventHub
//
//  Created by David on 21.12.25.
//


import Foundation
import Combine

final class ForgotPasswordViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?

    let onBackToSignIn: () -> Void

    init(onBackToSignIn: @escaping () -> Void) {
        self.onBackToSignIn = onBackToSignIn
    }

    func sendResetLink() {
        guard !email.isEmpty else {
            errorMessage = "Enter your email"
            successMessage = nil
            return
        }

        errorMessage = nil
        isLoading = true

        // MOCK
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isLoading = false
            self.successMessage = "Sent to your email."
        }
    }

    func backTapped() {
        onBackToSignIn()
    }
}
