//
//  EventDetailSpeakersSection.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import SwiftUI

struct EventDetailSpeakersSection: View {
    let speakers: [SpeakerItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Featured Speakers")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)

            VStack(spacing: 12) {
                ForEach(speakers) { speaker in
                    SpeakerRow(speaker: speaker)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

struct SpeakerRow: View {
    let speaker: SpeakerItem

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color(.systemGray5))
                .frame(width: 40, height: 40)
                .overlay(
                    Text(String(speaker.name.prefix(1)))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(.systemGray))
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(speaker.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                Text(speaker.role)
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))
            }

            Spacer()
        }
    }
}

