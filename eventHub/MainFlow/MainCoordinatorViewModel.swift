//
//  MainCoordinatorViewModel.swift
//  eventHub
//
//  Created by David on 20.12.25.
//


import SwiftUI
import Combine

final class MainCoordinatorViewModel: ObservableObject {

    enum Tab: Hashable {
        case home
        case browse
        case myEvents
        case notifications
        case profile
    }

    @Published var selectedTab: Tab = .home

    @Published var homeNavigationPath = NavigationPath()

    func openEventDetails(title: String) {
        homeNavigationPath.append(title)
    }

    func switchToHome() {
        selectedTab = .home
    }
}
