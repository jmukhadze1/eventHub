//
//  HomeCardStyle.swift
//  eventHub
//
//  Created by David on 22.12.25.
//

import SwiftUI

struct EventCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.systemGray3).opacity(0.35), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 1)
    }
}

extension View {
    func eventCardStyle() -> some View {
        self.modifier(EventCardStyle())
    }
}
