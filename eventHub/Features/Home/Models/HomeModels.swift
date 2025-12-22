//
//  HomeModels.swift
//  eventHub
//
//  Created by David on 22.12.25.
//

import Foundation

// MARK: - Models
struct UpcomingEventItem: Identifiable {
    let id = UUID()
    let day: String
    let month: String
    let title: String
    let timeRange: String
    let location: String
    let description: String
    let metaText: String
    let statusLabel: String?
}

struct CategoryItem: Identifiable {
    let id = UUID()
    let systemImageName: String
    let title: String
    let subtitle: String
}

struct TrendingEventItem: Identifiable {
    let id = UUID()
    let title: String
    let dateRange: String
}

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}
