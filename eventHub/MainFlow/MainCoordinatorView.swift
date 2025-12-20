//
//  MainCoordinatorView.swift
//  eventHub
//
//  Created by David on 20.12.25.
//


import SwiftUI

struct MainCoordinatorView: View {

    let onLogoutRequested: () -> Void

    @StateObject private var viewModel = MainCoordinatorViewModel()

    init(onLogoutRequested: @escaping () -> Void) {
        self.onLogoutRequested = onLogoutRequested
    }

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {

            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(MainCoordinatorViewModel.Tab.home)

            NavigationStack {
            }
            .tabItem {
                Label("Browse", systemImage: "magnifyingglass")
            }

            NavigationStack {
            }
            .tabItem {
                Label("My Events", systemImage: "calendar")
            }

            NavigationStack {
            }
            .tabItem {
                Label("Notifications", systemImage: "bell")
            }

            NavigationStack {
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }
}
