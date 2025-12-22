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

// სერვისის პროტოკოლი – აქ ექნება ნამდვილი API
protocol HomeDataServiceProtocol {
    func fetchHomeScreenData() async throws -> HomeScreenData
}

//Mock
struct MockHomeDataService: HomeDataServiceProtocol {

    func fetchHomeScreenData() async throws -> HomeScreenData {
        try await Task.sleep(nanoseconds: 300_000_000)

        let upcoming: [UpcomingEventItem] = [
            UpcomingEventItem(
                day: "18",
                month: "JAN",
                title: "Annual Team Building Summit",
                timeRange: "08:00 AM – 05:00 PM",
                location: "Grand Conference Hall",
                description: "Join us for a full day of engaging activities and networking opportunities.",
                metaText: "102 registered • 8 spots left",
                statusLabel: nil
            ),
            UpcomingEventItem(
                day: "20",
                month: "JAN",
                title: "Leadership Workshop",
                timeRange: "02:00 PM – 04:30 PM",
                location: "Training Room B",
                description: "Enhance your leadership skills with this interactive workshop.",
                metaText: "28 registered • 2 spots left",
                statusLabel: nil
            ),
            UpcomingEventItem(
                day: "24",
                month: "JAN",
                title: "Happy Friday: Game Night",
                timeRange: "06:00 PM – 09:00 PM",
                location: "Recreation Lounge",
                description: "Unwind after a productive week with board games and video games.",
                metaText: "30 registered • Full",
                statusLabel: "Waitlisted"
            )
        ]

        let categories: [CategoryItem] = [
            CategoryItem(systemImageName: "person.3",         title: "Team Building",  subtitle: "12 events"),
            CategoryItem(systemImageName: "sportscourt",      title: "Sports",         subtitle: "8 events"),
            CategoryItem(systemImageName: "hammer",           title: "Workshops",      subtitle: "18 events"),
            CategoryItem(systemImageName: "sun.max",          title: "Happy Fridays",  subtitle: "4 events"),
            CategoryItem(systemImageName: "globe",            title: "Cultural",       subtitle: "6 events"),
            CategoryItem(systemImageName: "heart.text.square",title: "Wellness",       subtitle: "9 events")
        ]

        let trending: [TrendingEventItem] = [
            TrendingEventItem(
                title: "Tech Talk: AI in Business",
                dateRange: "Jan 26, 2025"
            ),
            TrendingEventItem(
                title: "Annual Hackathon",
                dateRange: "Feb 10–12, 2025"
            )
        ]

        let faq: [FAQItem] = [
            FAQItem(
                question: "What if I need to cancel?",
                answer: "You can cancel your registration up to 24 hours before the event through this app. This will allow someone from the waitlist to attend."
            )
        ]

        return HomeScreenData(
            upcomingEvents: upcoming,
            categories: categories,
            trendingEvents: trending,
            faqItems: faq
        )
    }
}
