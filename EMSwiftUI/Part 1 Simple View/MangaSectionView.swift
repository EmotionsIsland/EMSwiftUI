//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    @ObservedObject var viewModel: MangaListViewModel
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 25), count: 3)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            MangaSectionBlockView(title: "Popular",
                                  mangaList: viewModel.mangaList,
                                  viewModel: viewModel,
                                  gridColumns: columns
            )
            MangaSectionBlockView(title: "Trending",
                                  mangaList: viewModel.mangaList,
                                  viewModel: viewModel,
                                  gridColumns: columns
            )
        }
        .padding(.horizontal, 16)
    }
}
