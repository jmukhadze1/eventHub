//
//  HomeView.swift
//  eventHub
//
//  Created by David on 20.12.25.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            Color(red: 250/255, green: 250/255, blue: 250/255)
                   .opacity(0.5)
                   .ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text(error)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)

                    Button("Try again") {
                        Task {
                            await viewModel.loadHomeScreen()
                        }
                    }
                }
                .padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                          HomeHeaderSection(userFirstName: viewModel.userFirstName)

                        UpcomingEventsSection(events: viewModel.upcomingEvents)

                          CategorySection(categories: viewModel.categories)
                          TrendingEventsSection(trendingEvents: viewModel.trendingEvents)
                          FAQSection(faqItems: viewModel.faqItems)
                      }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
        }
        .task {
            await viewModel.loadHomeScreen()
        }
    }
}
