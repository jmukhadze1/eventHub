//
//  TeamBuildingEventCardView.swift
//  eventHub
//
//  Created by David on 23.12.25.
//


import SwiftUI

struct TeamBuildingEventCardView: View {
    let item: TeamBuildingEventItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray5))
                .frame( height: 140)
                .overlay(
                    Text("Event Image: \(item.title)")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                )

            HStack(alignment: .top) {
                Text(item.title)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Spacer()

                Text(item.badgeText)
                    .font(.system(size: 11, weight: .medium))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color(.systemGray3), lineWidth: 1)
                            )
                    )
            }

            Text(item.subtitle)
                .font(.system(size: 13))
                .foregroundColor(Color(.systemGray))

            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))
                Text(item.dateText)
                    .font(.system(size: 13))
                    .foregroundColor(Color(.systemGray))
            }

            HStack(spacing: 6) {
                Image(systemName: "clock")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))
                Text(item.timeText)
                    .font(.system(size: 13))
                    .foregroundColor(Color(.systemGray))
            }

            HStack(spacing: 6) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))
                Text(item.location)
                    .font(.system(size: 13))
                    .foregroundColor(Color(.systemGray))
            }

            Button {} label: {
                Text(item.actionTitle)
                    .font(.system(size: 15, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}


