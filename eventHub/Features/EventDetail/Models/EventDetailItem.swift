//
//  EventDetailItem.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import Foundation

struct EventDetailItem: Identifiable {
    let id: String

    let title: String
    let categoryTag: String
    let levelTag: String

    let dateText: String
    let timeText: String
    let locationText: String
    let registrationMetaText: String
    let registrationNote: String

    let aboutText: String

    let agendaItems: [AgendaItem]
    let speakers: [SpeakerItem]
}

struct AgendaItem: Identifiable {
    let id = UUID()
    let timeText: String
    let title: String
    let description: String
}

struct SpeakerItem: Identifiable {
    let id = UUID()
    let name: String
    let role: String
}

// Mock data – Preview/MockService-სთვის
enum EventDetailMockData {
    static let sample = EventDetailItem(
        id: "event_1",
        title: "Leadership Workshop: Effective Communication",
        categoryTag: "Workshop",
        levelTag: "Beginner",
        dateText: "December 20, 2025",
        timeText: "02:00 PM – 04:30 PM",
        locationText: "Training Room B, Building 4",
        registrationMetaText: "129 registered, 7 spots left",
        registrationNote: "Registration closes on Dec 19, 2025 at 5:00 PM.",
        aboutText: """
Enhance your leadership skills with this interactive workshop focusing on communication strategies, active listening, and team motivation techniques. This session is designed for new and aspiring leaders looking to build a strong foundation in effective team management and communication.
""",
        agendaItems: [
            AgendaItem(
                timeText: "02:00 PM – Welcome & Introduction",
                title: "Welcome & Introduction",
                description: "Overview of the workshop goals and key topics."
            ),
            AgendaItem(
                timeText: "02:15 PM – The Art of Active Listening",
                title: "The Art of Active Listening",
                description: "Interactive exercises on understanding and responding."
            ),
            AgendaItem(
                timeText: "03:30 PM – Q&A and Closing Remarks",
                title: "Q&A and Closing Remarks",
                description: "Open forum and summary of key takeaways."
            )
        ],
        speakers: [
            SpeakerItem(
                name: "Sarah Johnson",
                role: "VP of Human Resources"
            ),
            SpeakerItem(
                name: "David Chen",
                role: "Lead Corporate Trainer"
            )
        ]
    )
}
