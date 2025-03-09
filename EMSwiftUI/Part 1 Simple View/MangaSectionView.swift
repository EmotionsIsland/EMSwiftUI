//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

enum MangaTitle {
    case popular, latest
}

extension MangaTitle {
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .latest:
            return "Latest"
        }
    }
}

struct MangaSectionView: View {
    
    @ObservedObject var viewModel: MangaListViewModel
    
    let columns: [GridItem] = Array(repeating: GridItem(spacing: 25), count: 3)
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 16) {
                MangaSectionTitleView(title: MangaTitle.popular.title)
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
            VStack(alignment: .leading, spacing: 16) {
                MangaSectionTitleView(title: MangaTitle.latest.title)
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.mangaData) { manga in
                        MangaSingleGridView(
                            title: manga.attributes.title.en ?? "Untitled",
                            coverURL: viewModel.getCoverURL(
                                manga: manga,
                                sizeFormat: .size256),
                            genre: manga.attributes.tags.first?.attributes.name.en ?? "Unknown genre"
                        )
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
