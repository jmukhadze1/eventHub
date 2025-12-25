////
////  APIDebugView.swift
////  eventHub
////
////  Created by David on 25.12.25.
////
//
//
//import SwiftUI
//struct APIDebugView: View {
//    @State private var status: String = "Idle"
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("API Debug")
//                .font(.headline)
//
//            Text(status)
//                .font(.subheadline)
//
//            Button("Load /api/events") {
//                Task {
//                    await loadEvents()
//                }
//            }
//        }
//    }
//
//    private func loadEvents() async {
//        do {
//            let page = try await NetworkClient.shared.getEventsPage(page: 1, pageSize: 10)
//
//            status = "✅ Loaded \(page.items.count) events (total: \(page.totalCount))"
//
//            if let first = page.items.first {
//                print("FIRST EVENT ----------")
//                print("id:", first.eventId)
//                print("title:", first.title)
//                print("category:", first.category.name)
//                print("start:", first.date.startDate)
//                print("location:", first.location.venueName)
//                print("----------------------")
//            }
//
//        } catch {
//            status = "❌ \(error.localizedDescription)"
//            print("EVENTS ERROR:", error)
//        }
//    }
//}
