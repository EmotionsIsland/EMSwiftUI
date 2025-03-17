//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    @ObservedObject var viewModel: MangaListViewModel
    let title: String
    let mangaList: [MangaData]
    private let columns = Array(repeating: GridItem(.fixed(100), spacing: 25), count: 3)
   
    var body: some View {
        VStack {
            MangaSectionTitleView(sectionTitle: title)
                        .padding(.horizontal, 4)
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(mangaList) { manga in
                            MangaSingleGridView(viewModel: viewModel, manga: manga)
                        }
                    }
            }
        
        }
}
