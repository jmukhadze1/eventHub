//
//  EventDetailView.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import SwiftUI

struct EventDetailView: View {
    @StateObject private var viewModel: EventDetailViewModel

    init(eventId: String, service: EventDetailServiceProtocol) {
        _viewModel = StateObject(
            wrappedValue: EventDetailViewModel(eventId: eventId, service: service)
        )
    }

    var body: some View {
        content
            .background(Color(.systemGray6).ignoresSafeArea())
            .navigationTitle("Event Details")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.load()
            }
    }

    // MARK: - UI states

    @ViewBuilder
    private var content: some View {
        if let event = viewModel.event {
            scrollContent(event: event)
        } else if viewModel.isLoading {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        } else if let error = viewModel.errorMessage {
            VStack(spacing: 12) {
                Text(error)
                    .foregroundColor(.red)
                Button("Retry") {
                    Task { await viewModel.load() }
                }
            }
            .padding()
        } else {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }


    private func scrollContent(event: EventDetailItem) -> some View {
        ScrollView {
            VStack(spacing: 1) {
                EventDetailBannerSection()
                EventDetailMainInfoSection(event: event)
                EventDetailAboutSection(text: event.aboutText)
                EventDetailAgendaSection(items: event.agendaItems)
                EventDetailSpeakersSection(speakers: event.speakers)
                Spacer(minLength: 20)
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    NavigationStack {
        EventDetailView(
            eventId: "event_1",
            service: MockEventDetailService()
        )
    }
}
