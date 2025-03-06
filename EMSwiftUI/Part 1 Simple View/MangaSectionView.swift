//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let sectionTitle: String
    
    var body: some View {
        VStack {
            MangaSectionTitleView(sectionTitle: sectionTitle)
            mangaGrid
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private let mangaColumns: [GridItem] = [
        GridItem(.flexible(), spacing: Const.Layout.gridPadding),
        GridItem(.flexible(), spacing: Const.Layout.gridPadding),
        GridItem(.flexible())
    ]
    
    private var mangaGrid: some View {
        LazyVGrid(columns: mangaColumns) {
            ForEach(Array(0..<Const.Other.maxMangaSectionNumber), id: \.self) { manga in
                MangaSingleGridView(mangaImage: Const.MockMangaData.mangaImage,
                                    mangaTitle: Const.MockMangaData.mangaTitle,
                                    mangarating: Const.MockMangaData.mangarating,
                                    description: Const.MockMangaData.description)
            }
        }
    }
}

#Preview {
    MangaSectionView(sectionTitle: Const.Layout.popularSectionTitle)
}
