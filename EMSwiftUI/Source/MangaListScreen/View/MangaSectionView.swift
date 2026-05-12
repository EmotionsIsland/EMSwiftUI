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

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 25),
        count: 3
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            MangaSectionTitleView(title: title)

            LazyVGrid(columns: columns, spacing: 25) {
                content
            }
        }
        .padding(.horizontal)
    }
}
