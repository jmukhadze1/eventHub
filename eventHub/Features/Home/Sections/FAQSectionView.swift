//
//  FAQSectionView.swift
//  eventHub
//
//  Created by David on 21.12.25.
//


import SwiftUI

struct FAQSection: View {

    let faqItems: [FAQItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Frequently Asked Questions")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)

            ForEach(faqItems) { item in
                FAQCardView(item: item)
            }
        }
    }
}

struct FAQCardView: View {

    let item: FAQItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.question)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)

            Text(item.answer)
                .font(.system(size: 13))
                .foregroundColor(Color(.systemGray))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .background(Color.white)    
      
    }
}
