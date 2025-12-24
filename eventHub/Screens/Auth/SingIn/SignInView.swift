//
//  SignInView.swift
//  eventHub
//
//  Created by David on 20.12.25.
//

import SwiftUI

struct SignInView: View {

    @StateObject private var viewModel: SignInViewModel

    init(
        onSignInSuccess: @escaping () -> Void,
        onSignUp: @escaping () -> Void,
        onForgotPassword: @escaping () -> Void
    ) {
        _viewModel = StateObject(
            wrappedValue: SignInViewModel(
                onSignInSuccess: onSignInSuccess,
                onSignUp: onSignUp,
                onForgotPassword: onForgotPassword
            )
        )
    }

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 0) {

                Spacer().frame(height: 80)

                VStack(spacing: 8) {
                    Text("Sign In")
                        .font(.system(size: 26, weight: .semibold))

                    Text("Enter your credentials to access your account")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemGray))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 40)

                VStack(alignment: .leading, spacing: 22) {

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.system(size: 13))
                            .foregroundColor(.black)

                        TextField("Enter your email", text: $viewModel.email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                            )
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.system(size: 13))
                            .foregroundColor(.black)

                        SecureField("Enter your password", text: $viewModel.password)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                            )
                    }

                    HStack {
                        Button(action: { viewModel.rememberMe.toggle() }) {
                            HStack(spacing: 6) {
                                Image(systemName: viewModel.rememberMe ? "checkmark.square" : "square")
                                Text("Remember me")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                            }
                        }
                        .buttonStyle(.plain)

                        Spacer()

                        Button(action: viewModel.onForgotPassword) {
                            Text("Forgot password?")
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 32)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                        .padding(.horizontal, 32)
                }

                Button(action: viewModel.signInTapped) {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    } else {
                        Text("Sign In")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                }
                .background(Color.black)
                .cornerRadius(4)
                .padding(.horizontal, 32)
                .padding(.top, 28)

                HStack(spacing: 4) {
                    Text("Don't have an account?")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemGray))

                    Button(action: viewModel.onSignUp) {
                        Text("Sign up")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 18)

                Spacer()
            }
        }
    }
}
