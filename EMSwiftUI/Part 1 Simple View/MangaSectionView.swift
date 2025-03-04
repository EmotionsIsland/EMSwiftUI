//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    @ObservedObject var viewModel: MangaListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            MangaSectionTitleView(title: "Popular")
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 25), count: 3),
                spacing: 25
            ) {
                ForEach(viewModel.mangaList) { manga in
                    MangaSingleGridView(
                        manga: manga,
                        coverURL: viewModel.getCoverURL(manga: manga, sizeFormat: .size512)
                    )
                }
            }
            
            MangaSectionTitleView(title: "Popular")
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 25), count: 3),
                spacing: 25
            ) {
                ForEach(viewModel.mangaList) { manga in
                    MangaSingleGridView(
                        manga: manga,
                        coverURL: viewModel.getCoverURL(manga: manga, sizeFormat: .size512)
                    )
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    MainView()
}
