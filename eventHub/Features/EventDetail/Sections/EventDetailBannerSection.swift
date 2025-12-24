//
//  EventDetailBannerSection.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import SwiftUI

struct EventDetailBannerSection: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(Color(.systemGray5))
            .frame(height: 180)
            .overlay(
                Text("Event Banner Image")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
            )
            .padding(.top, 8)
    }
}

#Preview {
    ZStack {
        Color(.systemGray6).ignoresSafeArea()
        EventDetailBannerSection()
    }
}
