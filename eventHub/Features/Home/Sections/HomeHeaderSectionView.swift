//
//  HomeHeaderSectionView.swift
//  eventHub
//
//  Created by David on 22.12.25.
//

import SwiftUI

struct HomeHeaderSection: View {

    let userFirstName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.black)
                    .frame(width: 32, height: 32)

                Text("EventHub")
                    .font(.headline)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "bell")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }

                Button(action: {}) {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 22))
                        .foregroundColor(.black)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome back, \(userFirstName)")
                    .font(.system(size: 24, weight: .bold))

                Text("Stay connected with upcoming company events and activities.")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
            }
        }
    }
}
