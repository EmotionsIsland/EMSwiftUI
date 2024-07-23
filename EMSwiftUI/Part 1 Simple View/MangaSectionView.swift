//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    private let sectionTitles = ["Popular",
                                 "Recently Added",
                                 "Last updates",
                                 "Seasonal"]
    
    let viewModel: MangaListViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(sectionTitles, id: \.self) { title in
                VStack {
                    MangaSectionTitleView(title: title)
                    
                    HStack(spacing: 29) {
                        buildSection(mangas: viewModel.mangasForGridView(with: 0))
                        buildSection(mangas: viewModel.mangasForGridView(with: 1))
                        buildSection(mangas: viewModel.mangasForGridView(with: 2))
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

extension MangaSectionView {
    func buildSection(mangas: [MangaData]) -> some View {
        MangaSingleGridView(
            mangaData: mangas,
            viewModel: viewModel
        )
    }
}
