//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let sectionTitle: String
    let models: [MangaViewModel]

    private let rows: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 25, alignment: .leading), count: 3)

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            MangaSectionTitleView(sectionTitle: sectionTitle)
            LazyVGrid(columns: columns, alignment: .center) {
                ForEach(models) { model in
                    MangaSingleGridView(model: model)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
