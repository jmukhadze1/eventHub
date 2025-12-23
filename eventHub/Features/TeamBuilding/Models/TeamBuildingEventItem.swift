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
    
    let badgeText: String
    
    let actionTitle: String
}
