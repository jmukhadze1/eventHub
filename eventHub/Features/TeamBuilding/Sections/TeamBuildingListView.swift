//
//  TeamBuildingListView.swift
//  eventHub
//
//  Created by David on 23.12.25.
//

import SwiftUI

struct TeamBuildingListView: View {

    @StateObject private var viewModel: TeamBuildingViewModel

    init() {
        _viewModel = StateObject(
            wrappedValue: TeamBuildingViewModel(service: MockTeamBuildingDataService())
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                TeamBuildingFiltersView()
                    .padding(.top, 8)

                ForEach(viewModel.events) { event in
                    TeamBuildingEventCardView(item: event)
                }
            }
            .padding(.vertical, 12)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Team Building")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // TODO:  search 
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 17, weight: .regular))
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    NavigationStack {
        TeamBuildingListView()
    }
}
