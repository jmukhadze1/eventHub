//
//  EventDetailAgendaSection.swift
//  eventHub
//
//  Created by David on 24.12.25.
//

import SwiftUI

struct EventDetailAgendaSection: View {
    let items: [AgendaItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Agenda")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)

            VStack(spacing: 12) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    AgendaRow(index: index + 1, item: item)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

struct AgendaRow: View {
    let index: Int
    let item: AgendaItem

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 22, height: 22)
                Text("\(index)")
                    .font(.system(size: 12, weight: .semibold))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(item.timeText)
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))

                Text(item.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)

                Text(item.description)
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))
            }

            Spacer()
        }
    }
}

