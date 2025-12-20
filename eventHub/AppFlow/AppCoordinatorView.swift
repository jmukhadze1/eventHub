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
            case .main:
                MainCoordinatorView(
                    onLogoutRequested: {
                        // Logout ღილაკი
                        viewModel.showAuth()
                    }
                )

            case .auth:
                Text("Auth Flow ")
                    .onAppear {
                        // დროებით, ავტომატურად გადავდივართ main-ზე
                        DispatchQueue.main.async {
                            viewModel.showMain()
                        }
                    }
            }
        }
    }
}
