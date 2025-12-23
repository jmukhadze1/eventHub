//
//  TeamBuildingViewModel.swift
//  eventHub
//
//  Created by David on 23.12.25.
//



import Foundation
import Combine

@MainActor
final class TeamBuildingViewModel: ObservableObject {
    
    @Published var events: [TeamBuildingEventItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: TeamBuildingDataServiceProtocol
    
    init(service: TeamBuildingDataServiceProtocol) {
        self.service = service
    }
    
    func load() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let items = try await service.fetchTeamBuildingEvents()
            self.events = items
        } catch {
            self.errorMessage = "ვერ ჩაიტვირთა ღონისძიებების სია"
        }
        
        isLoading = false
    }
}
