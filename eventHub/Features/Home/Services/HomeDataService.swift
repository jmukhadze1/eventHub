//
//  HomeDataService.swift
//  eventHub
//
//  Created by David on 22.12.25.
//

import Foundation


struct HomeScreenData {
    let upcomingEvents: [UpcomingEventItem]
    let categories: [CategoryItem]
    let trendingEvents: [TrendingEventItem]
    let faqItems: [FAQItem]
}


protocol HomeDataServiceProtocol {
    func fetchHomeScreenData() async throws -> HomeScreenData
}


struct APIHomeDataService: HomeDataServiceProtocol {

    func fetchHomeScreenData() async throws -> HomeScreenData {
        let page = try await NetworkClient.shared.fetchEventsPage(page: 1, pageSize: 20)
        let events = page.items

        let upcoming = makeUpcomingEvents(from: events)
        let categories = makeCategories(from: events)
        let trending = makeTrending(from: events)
        let faq = makeFAQ(from: events)

        return HomeScreenData(
            upcomingEvents: upcoming,
            categories: categories,
            trendingEvents: trending,
            faqItems: faq
        )
    }

    // MARK: - UpcomingEventsSection mapping

    private func makeUpcomingEvents(from events: [EventRemote]) -> [UpcomingEventItem] {
        events.map { event in
            let start = event.date.startDate
            let end = event.date.endDate

            let day = start.formatted(.dateTime.day())
            let month = start.formatted(.dateTime.month(.abbreviated))

            let timeRange = "\(start.formatted(date: .omitted, time: .shortened)) – \(end.formatted(date: .omitted, time: .shortened))"

            let meta = "\(event.capacity.currentlyRegistered) registered • max \(event.capacity.maxCapacity)"

            let statusLabel: String?
            if event.registrationStatus == "Open" {
                statusLabel = nil
            } else {
                statusLabel = event.registrationStatus 
            }

            return UpcomingEventItem(
                id: event.eventId, 
                day: day,
                month: month,
                title: event.title,
                timeRange: timeRange,
                location: event.location.venueName,
                description: event.description,
                metaText: meta,
                statusLabel: statusLabel
            )
        }
    }

    // MARK: - CategorySection mapping

    private func makeCategories(from events: [EventRemote]) -> [CategoryItem] {
        var counts: [String: Int] = [:]

        for event in events {
            let name = event.category.name
            counts[name, default: 0] += 1
        }

        let items: [CategoryItem] = counts.map { (name, count) in
            CategoryItem(
                systemImageName: sfSymbol(for: name),
                title: readableCategoryName(name),
                subtitle: "\(count) events"
            )
        }

        return items.sorted { $0.title < $1.title }
    }

    private func sfSymbol(for category: String) -> String {
        switch category {
        case "TeamBuilding":
            return "person.3"
        case "Sports":
            return "sportscourt"
        case "Workshop":
            return "hammer"
        case "Wellness":
            return "heart.text.square"
        default:
            return "calendar"
        }
    }

    private func readableCategoryName(_ raw: String) -> String {
        switch raw {
        case "TeamBuilding": return "Team Building"
        default: return raw
        }
    }

    // MARK: - TrendingEventsSection mapping

    private func makeTrending(from events: [EventRemote]) -> [TrendingEventItem] {
        let sorted = events.sorted {
            $0.capacity.currentlyRegistered > $1.capacity.currentlyRegistered
        }

        let top = Array(sorted.prefix(5))

        return top.map { event in
            let start = event.date.startDate
            let end = event.date.endDate

            let startStr = start.formatted(.dateTime.day().month().year())
            let endStr = end.formatted(.dateTime.day().month().year())

            let dateRange: String
            if startStr == endStr {
                dateRange = startStr
            } else {
                dateRange = "\(startStr) – \(endStr)"
            }

            return TrendingEventItem(
                title: event.title,
                dateRange: dateRange
            )
        }
    }

    // MARK: - FAQSection
    private func makeFAQ(from events: [EventRemote]) -> [FAQItem] {

        [
            FAQItem(
                question: "What if I need to cancel?",
                answer: "You can cancel your registration up to 24 hours before the event through this app. This will allow someone from the waitlist to attend."
            ),
          
        ]
    }
}
