//
//  HomeViewModel.swift
//  eventHub
//
//  Created by David on 20.12.25.
//

import SwiftUI
import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - UI data
    @Published var upcomingEvents: [UpcomingEventItem] = []
    @Published var categories: [CategoryItem] = []
    @Published var trendingEvents: [TrendingEventItem] = []
    @Published var faqItems: [FAQItem] = []

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    let userFirstName: String = "Sarah"


    private let dataService: HomeDataServiceProtocol

       init(dataService: HomeDataServiceProtocol = APIHomeDataService()) {
           self.dataService = dataService
       }
    // MARK: - Intent
    func loadHomeScreen() async {
        isLoading = true
        errorMessage = nil

        do {
            let data = try await dataService.fetchHomeScreenData()
            upcomingEvents = data.upcomingEvents
            categories     = data.categories
            trendingEvents = data.trendingEvents
            faqItems       = data.faqItems
            isLoading      = false
        } catch {
            isLoading = false
            errorMessage = "ვერ ჩაიტვირთა მთავარი გვერდის მონაცემები."
        }
    }
}
