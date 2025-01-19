//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let mangaSection: String
    let mangas: [MangaData]
    let moreButton: () -> Void
    let coverURL: (MangaData) -> URL
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 25), count: 3)
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(mangas) { manga in
                MangaSingleGridView(manga: manga, coverURL: coverURL)
            }
        }
        .padding(.horizontal, 16)
    }
}


