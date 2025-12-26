//
//  EventsPageResponse.swift
//  eventHub
//
//  Created by David on 25.12.25.
//


import Foundation

struct EventsPageResponse: Decodable {
    let items: [EventRemote]
    let totalCount: Int?
    let page: Int?
    let pageSize: Int?
    let totalPages: Int?
}

struct EventRemote: Decodable, Identifiable {
    let eventId: Int
    let organizerId: Int

    let title: String
    let organizer: OrganizerRemote
    let description: String
    let category: EventCategoryRemote
    let agenda: [AgendaItemRemote]
    let imgUrl: String?
    let userStatus: String
    let registrationStatus: String
    let speakers: [SpeakerRemote]
    let date: EventDateRemote
    let location: EventLocationRemote
    let capacity: EventCapacityRemote

    var id: Int { eventId }
}

struct OrganizerRemote: Decodable {
    let fullName: String
    let jobTitle: String?
    let department: String?
    let profileImgUrl: String?
    let email: String
}

struct EventCategoryRemote: Decodable {
    let name: String
    let logoUrl: String

    enum CodingKeys: String, CodingKey {
        case name
        case logoUrl = "logourl"
    }
}

struct AgendaItemRemote: Decodable {
    let startTime: String
    let duration: String
    let title: String
    let description: String?
    let activityType: String?
    let activityLocation: String?
}

struct SpeakerRemote: Decodable {
    let fullName: String
    let role: String
    let description: String?
    let imgUrl: String?
}

struct EventDateRemote: Decodable {
    let eventType: String
    let startDate: Date
    let endDate: Date
    let registerDeadline: Date

    enum CodingKeys: String, CodingKey {
        case eventType = "eventtype"
        case startDate
        case endDate
        case registerDeadline
    }
}

struct EventLocationRemote: Decodable {
    let locationType: String
    let venueName: String
    let address: EventAddressRemote
    let roomNumber: String
    let floor: String
    let additionalNotes: String
}

struct EventAddressRemote: Decodable {
    let street: String
    let city: String
}

struct EventCapacityRemote: Decodable {
    let maxCapacity: Int
    let currentlyRegistered: Int
    let duration: Int
    let currentWaitingList: Int
}
struct UpcomingEventItem: Identifiable {
    let id: Int
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
