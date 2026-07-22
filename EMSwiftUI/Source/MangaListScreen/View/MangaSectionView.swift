//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let title: String
    let mangaList: [MangaModel]

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 30), count: 3)
    
    var body: some View {
        VStack(spacing: 16) {
            MangaSectionTitleView(title: title)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(mangaList) { manga in
                    MangaSingleGridView(manga: manga)
                }
            }
        }
        .padding([.horizontal, .top], 16)
        .padding(.bottom, 4)
    }
}
