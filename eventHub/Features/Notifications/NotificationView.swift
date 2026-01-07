//
//  NotificationView.swift
//  eventHub
//
//  Created by MacBook on 12/24/25.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject private var viewModel = NotificationsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar
            HStack {
                Text("Notifications")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.primary)
                }
            }
            .padding()
            
            CategoryTabsView(selectedCategory: $viewModel.selectedCategory)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if !viewModel.newNotifications.isEmpty {
                        SectionHeaderView(title: "NEW")
                        
                        ForEach(viewModel.newNotifications) { notification in
                            NotificationCardView(notification: notification)
                        }
                    }
                    
                    if !viewModel.earlierNotifications.isEmpty {
                        SectionHeaderView(title: "EARLIER")
                            .padding(.top, viewModel.newNotifications.isEmpty ? 0 : 20)
                        
                        ForEach(viewModel.earlierNotifications) { notification in
                            NotificationCardView(notification: notification)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
        }
    }
}

#Preview {
    NotificationsView()
}
