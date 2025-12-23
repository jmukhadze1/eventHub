//
//  TeamBuildingDataServiceProtocol.swift
//  eventHub
//
//  Created by David on 23.12.25.
//


import Foundation


protocol TeamBuildingDataServiceProtocol {
    func fetchTeamBuildingEvents() async throws -> [TeamBuildingEventItem]
}

// mock
struct MockTeamBuildingDataService: TeamBuildingDataServiceProtocol {
    
    func fetchTeamBuildingEvents() async throws -> [TeamBuildingEventItem] {
        try await Task.sleep(nanoseconds: 300_000_000)
        
        return [
            TeamBuildingEventItem(
                title: "Annual Team Building Summit",
                subtitle: "Join us for a full day of engaging activities and workshops.",
                dateText: "Fri, Dec 19, 2025",
                timeText: "09:00 AM - 05:00 PM",
                location: "Grand Conference Hall",
                status: .open(spotsLeft: 8)
            ),
            TeamBuildingEventItem(
                title: "Escape Room Challenge: The Heist",
                subtitle: "Work together to solve puzzles and escape before time runs out!",
                dateText: "Sat, Dec 20, 2025",
                timeText: "02:00 PM - 03:30 PM",
                location: "Downtown Puzzle House",
                status: .registered
            ),
            TeamBuildingEventItem(
                title: "Corporate Sports Day 2025",
                subtitle: "Friendly competition and fun across various sporting activities.",
                dateText: "Sun, Dec 28, 2025",
                timeText: "10:00 AM - 04:00 PM",
                location: "City Sports Complex",
                status: .fullWaitlist
            )
        ]
    }
}
