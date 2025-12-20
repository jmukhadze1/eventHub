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
                    onSignUp: { /* TODO:  SignUp მივაბათ */ },
                    onForgotPassword: {/* TODO:  Forgot მივაბათ */ }
                )
                
            case .main:
                MainCoordinatorView()
           
            }
        }
    }
}
