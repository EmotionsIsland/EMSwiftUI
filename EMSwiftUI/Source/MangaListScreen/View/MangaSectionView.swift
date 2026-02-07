//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    private let columns = [
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.SFPro.headline3)
                .foregroundColor(Color("PrimaryTextColor"))

            LazyVGrid(columns: columns, spacing: 25) {
                content
            }
        }
        .padding(.horizontal)
    }
}
