//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let title: String
    
    let mangas: [MangaRepresentable]
    
    let gridItems: [GridItem] = .init(repeating: GridItem(.fixed(100), spacing: 25, alignment: .top), count: 3)
    
    var body: some View {
        VStack {
            MangaSectionTitleView(title: title)
                .padding(.horizontal, 40)
            
            LazyVGrid(columns: gridItems) {
                ForEach(mangas) { manga in
                    MangaSingleGridView(
                        url: manga.imageUrl,
                        title: manga.title,
                        rating: manga.raing,
                        genres: manga.genres)
                    .frame(width: 100, height: 220)
                }
            }
        }
        .padding(.top, 10)
    }
}
