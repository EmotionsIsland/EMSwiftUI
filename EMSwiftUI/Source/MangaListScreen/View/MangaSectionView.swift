//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let section: MangaSection

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25)

    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            MangaSectionTitleView(title: section.title)

            LazyVGrid(columns: columns, alignment: .leading, spacing: 25) {
                ForEach(section.items) { item in
                    MangaSingleGridView(item: item)
                }
            }
        }
    }
}
