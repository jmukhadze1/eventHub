//
//  EventDetailAboutSection.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import SwiftUI

struct EventDetailAboutSection: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About this event")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)

            Text(text)
                .font(.system(size: 13))
                .foregroundColor(Color(.systemGray))
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}


