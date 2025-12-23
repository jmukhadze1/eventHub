//
//  TeamBuildingEventCardView.swift
//  eventHub
//
//  Created by David on 23.12.25.
//



import SwiftUI

struct TeamBuildingEventCardView: View {
    let item: TeamBuildingEventItem

    private let cardCornerRadius: CGFloat = 14
    private let imageCornerRadius: CGFloat = 12
    private let imageHeight: CGFloat = 140

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // MARK: - Image placeholder
            RoundedRectangle(cornerRadius: imageCornerRadius, style: .continuous)
                .fill(Color(.systemGray5))
                .frame(height: imageHeight)
                .overlay(
                    Text("Event Image: \(item.title)")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                )

            // MARK: - Title + badge
            HStack(alignment: .top, spacing: 8) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Spacer()

                Text(item.status.badgeText)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 100, style: .continuous)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color(.systemGray3), lineWidth: 1)
                            )
                    )
            }

            // MARK: - Description
            Text(item.subtitle)
                .font(.system(size: 13))
                .foregroundColor(Color(.systemGray))
                .multilineTextAlignment(.leading)

            // MARK: - Date / Time / Location
            VStack(alignment: .leading, spacing: 4) {

                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                    Text(item.dateText)
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                }

                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                    Text(item.timeText)
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                }

                HStack(spacing: 6) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                    Text(item.location)
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                }
            }

            // MARK: - Primary button
            Button {
                
            } label: {
                Text(item.status.actionTitle)
                    .font(.system(size: 15, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.top, 4)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: cardCornerRadius, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

//#Preview {
//    ZStack {
//        Color(.systemGray6).ignoresSafeArea()
//        TeamBuildingEventCardView(
//            item: TeamBuildingEventItem(
//                title: "Annual Team Building Summit",
//                subtitle: "Join us for a full day of engaging activities and workshops.",
//                dateText: "Fri, Dec 19, 2025",
//                timeText: "09:00 AM - 05:00 PM",
//                location: "Grand Conference Hall",
//                status: .open(spotsLeft: 8),
//            )
//        )
//        .padding(.horizontal, 16) 
//    }
//}
