//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    @ObservedObject var viewModel: MangaListViewModel
    
    let columns: [GridItem] = Array(repeating: GridItem(spacing: 25), count: 3)
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(viewModel.mangaTitle.allCases, id: \.self) { section in
                VStack(alignment: .leading, spacing: 16) {
                    MangaSectionTitleView(title: section.title)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.mangaData) { manga in
                            MangaSingleGridView(
                                title: manga.attributes.title.en ?? "Untitled",
                                coverURL: viewModel.getCoverURL(
                                    manga: manga,
                                    sizeFormat: .size256),
                                genre: manga.attributes.tags.first?.attributes.name.en ?? "Unknown"
                            )
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    MangaSectionView(viewModel: MangaListViewModel())
}
