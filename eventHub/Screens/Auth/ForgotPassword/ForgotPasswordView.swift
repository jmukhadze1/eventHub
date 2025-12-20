//
//  ForgotPasswordView.swift
//  eventHub
//
//  Created by David on 21.12.25.
//

import SwiftUI

struct ForgotPasswordView: View {

    @StateObject private var viewModel: ForgotPasswordViewModel

    init(onBackToSignIn: @escaping () -> Void) {
        _viewModel = StateObject(
            wrappedValue: ForgotPasswordViewModel(onBackToSignIn: onBackToSignIn)
        )
    }

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 0) {

                Spacer().frame(height: 80)

                VStack(spacing: 8) {
                    Text("Forgot Password")
                        .font(.system(size: 24, weight: .semibold))

                    Text("Enter your email and we'll send you a link to reset your password.")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemGray))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 36)

                VStack(alignment: .leading, spacing: 18) {

                    Text("Email")
                        .font(.system(size: 13))
                        .foregroundColor(.black)

                    ZStack(alignment: .leading) {
                        TextField("Enter your email", text: $viewModel.email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding(.leading, 34)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                            )

                        Image(systemName: "envelope")
                            .foregroundColor(Color(.systemGray))
                            .padding(.leading, 10)
                    }
                }
                .padding(.horizontal, 32)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                        .padding(.horizontal, 32)
                } else if let success = viewModel.successMessage {
                    Text(success)
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                        .padding(.horizontal, 32)
                }

                Button(action: viewModel.sendResetLink) {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    } else {
                        Text("Send Reset Link")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                }
                .background(Color.black)
                .cornerRadius(4)
                .padding(.horizontal, 32)
                .padding(.top, 28)

                Button(action: viewModel.backTapped) {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.left")
                        Text("Back to Sign In")
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                }
                .padding(.top, 18)

                Spacer()
            }
        }
    }
}
