//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
     let mangaList: [MangaData]
    
    private let columns: [GridItem] = Array(
        repeating: .init(.flexible(), spacing: 25), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 25) {
            ForEach(mangaList) { manga in
                MangaGridItemView(manga: manga)
            }
        }
    }
}

