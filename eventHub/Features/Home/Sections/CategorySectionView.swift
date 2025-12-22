//
//  CategorySectionView.swift
//  eventHub
//
//  Created by David on 21.12.25.
//

import SwiftUI

struct CategorySection: View {

    let categories: [CategoryItem]

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Browse by Category")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(categories) { category in
                    CategoryCardView(category: category)
                }
            }
        }
    }
}

struct CategoryCardView: View {

    let category: CategoryItem

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: category.systemImageName)
                .font(.system(size: 20))
                .foregroundColor(.black)

            Text(category.title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            Text(category.subtitle)
                .font(.system(size: 11))
                .foregroundColor(Color(.systemGray))
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .padding(.vertical, 10)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray3).opacity(0.4), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.02), radius: 1, x: 0, y: 1)
    }
}
