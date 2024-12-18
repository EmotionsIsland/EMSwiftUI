//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    let mangaData: [MangaData]
    
    private let columns: [GridItem] = Array(
            repeating: .init(.flexible(), spacing: 25), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(mangaData) { manga in
                MangaSingleGridView(manga: manga)
            }
        }
    }
}
