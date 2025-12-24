//
//  EventDetailMainInfoSection.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import SwiftUI

struct EventDetailMainInfoSection: View {
    let event: EventDetailItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack(spacing: 8) {
                TagPill(text: event.categoryTag)
                TagPill(text: event.levelTag)
            }

            Text(event.title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

            VStack(alignment: .leading, spacing: 8) {
                InfoRow(icon: "calendar", text: event.dateText)
                InfoRow(icon: "clock", text: event.timeText)
                InfoRow(icon: "mappin.and.ellipse", text: event.locationText)
                InfoRow(icon: "person.2", text: event.registrationMetaText)
            }

            Button {
                // TODO: Register action
            } label: {
                Text("Register Now")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 11)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Text(event.registrationNote)
                .font(.system(size: 11))
                .foregroundColor(Color(.systemGray))
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

struct TagPill: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .medium))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color(.systemGray6))
            .foregroundColor(.black)
            .clipShape(Capsule())
    }
}

struct InfoRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(Color(.systemGray))
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(Color(.systemGray))
            Spacer()
        }
    }
}


