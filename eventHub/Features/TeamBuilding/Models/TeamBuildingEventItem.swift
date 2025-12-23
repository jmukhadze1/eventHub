//
//  TeamBuildingEventItem.swift
//  eventHub
//
//  Created by David on 23.12.25.
//


import Foundation

struct TeamBuildingEventItem: Identifiable {
    let id = UUID()
    
    let title: String
    let subtitle: String
    let dateText: String
    let timeText: String
    let location: String
    
    let status: TeamBuildingEventStatus
}

enum TeamBuildingEventStatus {
    case open(spotsLeft: Int?)
    case registered
    case fullWaitlist
}

extension TeamBuildingEventStatus {
    var badgeText: String {
        switch self {
        case .open(let spotsLeft):
            if let spots = spotsLeft {
                return "\(spots) spots left"
            } else {
                return "Open"
            }
        case .registered:
            return "Registered"
        case .fullWaitlist:
            return "Full (Waitlist)"
        }
    }
    
    var actionTitle: String {
        switch self {
        case .open:
            return "View Details"
        case .registered:
            return "View Details"
        case .fullWaitlist:
            return "Join Waitlist"
        }
    }
    
    var isActionFilled: Bool {
        switch self {
        case .open:
            return true          
        case .registered:
            return false         
        case .fullWaitlist:
            return true          
        }
    }
}
