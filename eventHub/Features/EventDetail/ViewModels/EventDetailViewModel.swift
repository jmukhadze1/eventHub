//
//  EventDetailViewModel.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import Foundation
import Combine
@MainActor
final class EventDetailViewModel: ObservableObject {

    @Published var event: EventDetailItem?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let eventId: String
    private let service: EventDetailServiceProtocol

    init(eventId: String, service: EventDetailServiceProtocol) {
        self.eventId = eventId
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            let detail = try await service.fetchEventDetail(id: eventId)
            self.event = detail
        } catch {
            self.errorMessage = "ვერ ჩაიტვირთა ღონისძიების დეტალები"
        }

        isLoading = false
    }
}
