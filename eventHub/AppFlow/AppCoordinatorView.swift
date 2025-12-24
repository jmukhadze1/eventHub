//
//  AppCoordinatorView.swift
//  eventHub
//
//  Created by David on 20.12.25.
//


import SwiftUI

struct AppCoordinatorView: View {

    @StateObject private var viewModel = AppCoordinatorViewModel()

    var body: some View {
        Group {
            switch viewModel.flow {
            case .auth:
                SignInView(
                    onSignInSuccess: { viewModel.showMain() },
                    onSignUp: { viewModel.signUp() },
                    onForgotPassword: {viewModel.showForgotPassword() }
                )
            case .signUp:
                SignUpView(
                    onBackToSignIn: {
                        viewModel.showAuth()
                    }
                )
                
            case .forgotPassword:
                         ForgotPasswordView(
                             onBackToSignIn: {
                                 viewModel.showAuth()
                             }
                         )
            case .main:
                MainCoordinatorView()
           
            }
        }
    }
}
