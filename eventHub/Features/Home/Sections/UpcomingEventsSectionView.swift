//
//  UpcomingEventsSectionView.swift
//  eventHub
//
//  Created by David on 21.12.25.
//

import SwiftUI

struct UpcomingEventsSection: View {

    let events: [UpcomingEventItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                Text("Upcoming Events")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                NavigationLink {
                    TeamBuildingListView(service: MockTeamBuildingDataService())
                } label: {
                    Text("View all")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                }
            }

            VStack(spacing: 14) {
                ForEach(events) { event in
                    UpcomingEventCardView(event: event)
                }
            }
        }
    }
}

struct UpcomingEventCardView: View {

    let event: UpcomingEventItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            VStack(spacing: 2) {
                Text(event.month.uppercased())
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Color(.systemGray))

                Text(event.day)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
            }
            .frame(width: 42)
            .padding(.top, 2)

            VStack(alignment: .leading, spacing: 6) {

                HStack(alignment: .top) {
                    Text(event.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)

                    Spacer()

                    if let status = event.statusLabel {
                        Text(status)
                            .font(.system(size: 11, weight: .medium))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray3), lineWidth: 1)
                            )
                    }
                }

                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 11))
                        .foregroundColor(Color(.systemGray))
                    Text(event.timeRange)
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))

                    Text("•")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))

                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 11))
                        .foregroundColor(Color(.systemGray))
                    Text(event.location)
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                }

                Text(event.description)
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))

                HStack(spacing: 6) {
                    HStack(spacing: 4) {
                        Image(systemName: "person.2")
                            .font(.system(size: 12))
                        Text(event.metaText)
                            .font(.system(size: 12))
                    }
                    .foregroundColor(Color(.systemGray))

                    Spacer()

                    Button(action: {}) {
                        HStack(spacing: 4) {
                               Text("View Details")
                                   .font(.system(size: 14, weight: .semibold))
                                   .foregroundColor(.black)
                               Image(systemName: "arrow.right")
                                   .font(.system(size: 12, weight: .semibold))
                                   .foregroundColor(.black)
                           }
                        .foregroundColor(.blue)
                    }
                }
                .padding(.top, 2)
            }
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 14)
        .eventCardStyle()
    }
}
