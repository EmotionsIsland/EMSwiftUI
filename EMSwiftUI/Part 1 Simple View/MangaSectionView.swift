//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let sectionTitle: String
    let mangaData: [MangaData]
    
    var body: some View {
        VStack {
            MangaSectionTitleView(sectionTitle: sectionTitle)
            mangaGrid
        }
        .padding([.horizontal, .bottom])
    }
}

private extension MangaSectionView {
    private var mangaColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: Const.Layout.gridPadding), count: 3)
    }
    
    private var mangaGrid: some View {
        LazyVGrid(columns: mangaColumns) {
            ForEach(mangaData) { manga in
                MangaSingleGridView(manga: manga)
            }
        }
    }
}
