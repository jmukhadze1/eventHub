//
//  AppCoordinatorViewModel.swift
//  eventHub
//
//  Created by David on 20.12.25.
//


import Foundation
import Combine
final class AppCoordinatorViewModel: ObservableObject {

    enum FlowState {
        case main
        case auth
        case forgotPassword
        case signUp
    }

    @Published var flow: FlowState = .auth

    func showMain() {
        flow = .main
    }

    func showAuth() {
        flow = .auth
    }
    func showForgotPassword() {
        flow = .forgotPassword
    }
    func signUp() {
        flow = .signUp
    }
}
