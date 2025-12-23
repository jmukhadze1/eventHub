//
//  TeamBuildingFiltersView.swift
//  eventHub
//
//  Created by David on 24.12.25.
//

import SwiftUI

struct TeamBuildingFiltersView: View {

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {

                Button {
                    // TODO: open filter sheet
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 12, weight: .semibold))
                        Text("Filters")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }

                TeamBuildingFilterChip(title: "Location")
                TeamBuildingFilterChip(title: "This Week")
            }
            .padding(.horizontal, 16)
        }
    }
}


struct TeamBuildingFilterChip: View {
    let title: String

    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.system(size: 13))
            Image(systemName: "chevron.down")
                .font(.system(size: 11, weight: .semibold))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color.white)
        .foregroundColor(.black)
        .clipShape(Capsule())
        .overlay(
            Capsule().stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}


#Preview {
    ZStack {
        Color(.systemGray6).ignoresSafeArea()
        VStack {
            TeamBuildingFiltersView()
            Spacer()
        }
    }
}
