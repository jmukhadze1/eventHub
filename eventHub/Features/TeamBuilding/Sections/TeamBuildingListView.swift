//
//  TeamBuildingListView.swift
//  eventHub
//
//  Created by David on 23.12.25.
//


import SwiftUI

struct TeamBuildingListView: View {
    
    @StateObject private var viewModel: TeamBuildingViewModel
    
    init(service: TeamBuildingDataServiceProtocol) {
        _viewModel = StateObject(
            wrappedValue: TeamBuildingViewModel(service: service)
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                filtersRow
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 40)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top, 40)
                } else {
                    ForEach(viewModel.events) { event in
                        TeamBuildingEventCardView(item: event)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Team Building")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
    
    // MARK: - Filters
    private var filtersRow: some View {
        HStack(spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "slider.horizontal.3")
                    .font(.caption)
                Text("Filters")
                    .font(.caption)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            FilterChip(title: "Location")
            
            FilterChip(title: "This Week")
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct FilterChip: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.caption)
            Image(systemName: "chevron.down")
                .font(.caption2)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(Color.white)
        .foregroundColor(.primary)
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        TeamBuildingListView(service: MockTeamBuildingDataService())
    }
}
