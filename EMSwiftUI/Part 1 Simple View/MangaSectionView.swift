//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    @State var title: String
    @StateObject private var viewModel = MangaListViewModel(mangaService: MangaListService(network: Network()))
    
    // Строки сетки
    private let rows = [
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25)
    ]
    
    var body: some View {
        VStack {
            // TODO: Create section View
            MangaSectionTitleView(title)
                .padding(.bottom, 20)
            LazyHGrid(rows: rows, spacing: 25) {
                ForEach(viewModel.manga.data) { mangaItem in
                    MangaSingleGridView(mangaData: mangaItem, mangaListViewModel: viewModel)
                }
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    MangaSectionView(title: "Popular")
}
