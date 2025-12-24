//
//  EventDetailServiceProtocol.swift
//  eventHub
//
//  Created by David on 24.12.25.
//



import Foundation

protocol EventDetailServiceProtocol {
    func fetchEventDetail(id: String) async throws -> EventDetailItem
}

// დროებითი Mock სერვისი
struct MockEventDetailService: EventDetailServiceProtocol {
    func fetchEventDetail(id: String) async throws -> EventDetailItem {
        try await Task.sleep(nanoseconds: 250_000_000)
        return EventDetailMockData.sample
    }
}
