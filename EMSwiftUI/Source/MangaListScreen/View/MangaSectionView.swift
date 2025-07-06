//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let mangaList: [MangaPresentationModel]
    private let rows: [GridItem] = [GridItem(), GridItem()]
    
    var body: some View {
        LazyHGrid(rows: rows, spacing: 25) {
            Section {
                ForEach(mangaList) { manga in
                    MangaSingleGridView(
                        cover: Image(uiImage: manga.cover ?? UIImage()),
                        title: manga.title,
                        group: manga.tags.joined(separator: ", "),
                        rating: manga.rating)
                }
            }
        }
    }
}
