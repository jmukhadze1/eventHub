//
//  TrendingEventsSectionView.swift
//  eventHub
//
//  Created by David on 21.12.25.
//

import SwiftUI

struct TrendingEventsSection: View {

    let trendingEvents: [TrendingEventItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Trending Events")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)

            Text("Popular events with high registration rates.")
                .font(.system(size: 12))
                .foregroundColor(Color(.systemGray))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(trendingEvents) { item in
                        TrendingEventCardView(item: item)
                    }
                }
            }
        }
    }
}

struct TrendingEventCardView: View {

    let item: TrendingEventItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemGray5))
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.top, 0)
                .padding(.horizontal, 0)

            VStack(alignment: .leading, spacing: 6) {

                Text(item.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(2)

                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .font(.system(size: 11))
                        .foregroundColor(Color(.systemGray))

                    Text(item.dateRange)
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                }
            }
            .padding(10)
        }
        .frame(width: 220)
        .eventCardStyle()
    }
}
