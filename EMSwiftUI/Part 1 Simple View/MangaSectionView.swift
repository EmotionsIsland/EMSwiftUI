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
        VStack(spacing: 0) {
            if let mangaModel = viewModel.mangaModel {
                MangaSectionTitleView(title: "Popular")
                mangaGrid(mangaModel: mangaModel)
            }
        }
    }
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)

}

private extension MangaSectionView {
    func mangaGrid(mangaModel: MangaListModel) -> some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(mangaModel.data, id: \.id) { data in
                MangaSingleGridView(viewModel: viewModel, data: data)
                    .padding()
            }
        }
    }
    
}
