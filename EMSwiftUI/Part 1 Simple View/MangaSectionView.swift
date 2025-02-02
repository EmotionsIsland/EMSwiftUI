//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let title: String
    let manga: [MangaData]
    let viewModel: MangaListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            MangaSectionTitleView(title: title)
            LazyHGrid(
                rows: Array(repeating: GridItem(.fixed(200), spacing: 25), count: 2),
                spacing: 25
            ) {
                ForEach(manga) { manga in
                    MangaSingleGridView(manga: manga, viewModel: viewModel)
                        .frame(width: 100, height: 200)
                }
            }
        }
        .padding(.horizontal)
    }
}
