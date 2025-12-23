//
//  TeamBuildingViewModel.swift
//  eventHub
//
//  Created by David on 23.12.25.
//


import Foundation
import Combine

@MainActor
class TeamBuildingViewModel: ObservableObject {
    @Published var events: [TeamBuildingEventItem] = []
    @Published var isLoading = false
    
    private let service: TeamBuildingDataServiceProtocol
    
    init(service: TeamBuildingDataServiceProtocol) {
        self.service = service
    }
    
    func load() async {
        isLoading = true
        events = (try? await service.fetchEvents()) ?? []
        isLoading = false
    }
}
