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
    }

    @Published var flow: FlowState = .auth

    func showMain() {
        flow = .main
    }

    func showAuth() {
        flow = .auth
    }
}
