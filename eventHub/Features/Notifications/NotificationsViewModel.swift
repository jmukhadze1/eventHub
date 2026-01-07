//
//  NotificationsViewModel.swift
//  eventHub
//
//  Created by MacBook on 12/24/25.
//


import Foundation
import Combine

class NotificationsViewModel: ObservableObject {
    @Published var selectedCategory: NotificationCategory = .all
    @Published var notifications: [NotificationItem] = []
    
    init() {
        loadNotifications()
    }
    
    var filteredNotifications: [NotificationItem] {
        guard selectedCategory != .all else { return notifications }
        return notifications.filter { $0.category == selectedCategory }
    }
    
    var newNotifications: [NotificationItem] {
        filteredNotifications.filter { $0.isNew }
    }
    
    var earlierNotifications: [NotificationItem] {
        filteredNotifications.filter { !$0.isNew }
    }
    
    private func loadNotifications() {
        notifications = [
            NotificationItem(
                type: .registration,
                title: "Registration Confirmed",
                message: "You are now registered for the 'Leadership Workshop: Effective Communication'.",
                timestamp: "15 minutes ago",
                isNew: true,
                category: .registrations
            ),
            NotificationItem(
                type: .reminder,
                title: "Event Reminder",
                message: "'Annual Team Building Summit' starts in 24 hours. Don't forget to join!",
                timestamp: "1 hour ago",
                isNew: true,
                category: .reminders
            ),
            NotificationItem(
                type: .update,
                title: "Event Update",
                message: "The location for 'Happy Friday: Game Night' has been changed to the Recreation Lounge.",
                timestamp: "Yesterday",
                isNew: false,
                category: .updates
            ),
            NotificationItem(
                type: .waitlist,
                title: "Waitlist Update",
                message: "A spot has opened up for 'Tech Talk: AI in Business Operations'. You have been automatically registered.",
                timestamp: "2 days ago",
                isNew: false,
                category: .updates
            ),
            NotificationItem(
                type: .cancellation,
                title: "Cancellation",
                message: "Your registration for the 'Wellness Wednesday Yoga' has been successfully cancelled.",
                timestamp: "Dec 12, 2025",
                isNew: false,
                category: .registrations
            )
        ]
    }
}
