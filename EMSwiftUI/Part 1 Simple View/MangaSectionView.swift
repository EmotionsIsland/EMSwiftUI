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
    let mangaData: [MangaData]
    let viewModel: MangaListViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(sectionTitles, id: \.self) { title in
                VStack {
                    MangaSectionTitleView(title: title)
                    
                    HStack(spacing: 29) {
                        ForEach(0..<3) { index in
                            let multiplier = index * 2
                            let subrange = (0 + multiplier)...(1 + multiplier)
                            let mangas = Array(mangaData[subrange])
                            MangaSingleGridView(
                                mangaData: mangas,
                                viewModel: viewModel
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}
