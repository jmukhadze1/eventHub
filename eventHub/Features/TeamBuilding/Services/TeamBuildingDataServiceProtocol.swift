//
//  TeamBuildingDataServiceProtocol.swift
//  eventHub
//
//  Created by David on 23.12.25.
//

import Foundation

protocol TeamBuildingDataServiceProtocol {
    func fetchEvents() async throws -> [TeamBuildingEventItem]
}

struct MockTeamBuildingDataService: TeamBuildingDataServiceProtocol {
    func fetchEvents() async throws -> [TeamBuildingEventItem] {
        return [
            TeamBuildingEventItem(
                title: "Annual Team Building Summit",
                subtitle: "Join us for a full day of engaging activities and workshops.",
                dateText: "Fri, Dec 19, 2025",
                timeText: "09:00 AM – 05:00 PM",
                location: "Grand Conference Hall",
                badgeText: "8 spots left",
                actionTitle: "View Details"
            ),
            TeamBuildingEventItem(
                title: "Escape Room Challenge: The Heist",
                subtitle: "Work together to solve puzzles and escape before time runs out!",
                dateText: "Sat, Dec 20, 2025",
                timeText: "02:00 PM – 03:30 PM",
                location: "Downtown Puzzle House",
                badgeText: "Registered",
                actionTitle: "View Details"
            ),
            TeamBuildingEventItem(
                title: "Corporate Sports Day 2025",
                subtitle: "Friendly competition and fun across various sporting activities.",
                dateText: "Sun, Dec 28, 2025",
                timeText: "10:00 AM – 04:00 PM",
                location: "City Sports Complex",
                badgeText: "Full (Waitlist)",
                actionTitle: "Join Waitlist"
            )
        ]
    }
}
