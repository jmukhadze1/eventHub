//
//  APITestView.swift
//  eventHub
//
//  Created by David on 24.12.25.
//

import SwiftUI

struct APITestView: View {

    @State private var status: String = "ტესტი ჯერ არ არის გაშვებული"

    var body: some View {
        VStack {
            Text("API Test")
                .font(.title)

            Text(status)
                .padding()
        }
        .task {
            await testAPI()
        }
    }

    private func testAPI() async {
        do {
            struct EventTest: Decodable {
                let id: Int
                let title: String?
            }

            let events: [EventTest] = try await NetworkClient.shared.get(
                "events",
                query: nil,
                authorized: false
            )

            status = " API WORKS — მივიდა პასუხი (\(events.count) items)"

        } catch let error as APIError {
            switch error {
            case .serverError(let code, _):
                status = " Request OK, API uptime OK → Status: \(code)"
            default:
                status = " API ERROR: \(error.localizedDescription)"
            }
        } catch {
            status = " API ERROR: \(error.localizedDescription)"
        }
    }
}

#Preview {
    APITestView()
}
