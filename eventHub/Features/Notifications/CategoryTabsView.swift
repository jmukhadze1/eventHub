//
//  CategoryTabsView.swift
//  eventHub
//
//  Created by MacBook on 12/24/25.
//


import SwiftUI

struct CategoryTabsView: View {
    @Binding var selectedCategory: NotificationCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(NotificationCategory.allCases, id: \.self) { category in
                    CategoryTabButton(
                        title: category.rawValue,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 50)
        .background(Color(UIColor.systemBackground))
        .overlay(
            Divider(),
            alignment: .bottom
        )
    }
}


struct CategoryTabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .primary : .secondary)
                
                Rectangle()
                    .fill(isSelected ? Color.primary : Color.clear)
                    .frame(height: 2)
            }
        }
    }
}


struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 13, weight: .semibold))
            .foregroundColor(.secondary)
            .padding(.vertical, 12)
    }
}


struct NotificationCardView: View {
    let notification: NotificationItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(notification.type.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .padding(8)
                .background(Color(UIColor.systemGray6))
                .clipShape(Circle())           

            
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.title + ": ")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                + Text(notification.message)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                
                Text(notification.timestamp)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
            
            Spacer()
            
            if notification.isNew {
                Circle()
                    .fill(Color.black)
                    .frame(width: 8, height: 8)
                    .padding(.top, 8)
            }
        }
        .padding(16)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        .padding(.vertical, 4)
    }
}

