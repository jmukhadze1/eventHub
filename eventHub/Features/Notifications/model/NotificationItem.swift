//
//  NotificationItem.swift
//  eventHub
//
//  Created by MacBook on 12/24/25.
//


import Foundation

struct NotificationItem: Identifiable {
    let id = UUID()
    let type: NotificationType
    let title: String
    let message: String
    let timestamp: String
    let isNew: Bool
    let category: NotificationCategory
}



enum NotificationType {
    case registration
    case reminder
    case update
    case cancellation
    case waitlist
    
    var icon: String {
        switch self {
        case .registration: return "RegistrationConfirmed"
        case .reminder: return "EventReminder"
        case .update: return "EventUpdate"
        case .cancellation: return "Cancellation"
        case .waitlist: return "WaitlistUpdate"
        }
    }
}



enum NotificationCategory: String, CaseIterable {
    case all = "All"
    case registrations = "Registrations"
    case reminders = "Reminders"
    case updates = "Updates"
}
