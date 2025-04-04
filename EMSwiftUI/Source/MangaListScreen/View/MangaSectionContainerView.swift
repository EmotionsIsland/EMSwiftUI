//
//  MangaSectionContainerView.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 4.04.25.
//

import SwiftUI

struct MangaSectionContainerView: View {
    let title: String
    let mangaList: [MangaData]
    let columns: [GridItem]
    let coverURLProvider: (MangaData) -> URL?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MangaSectionTitleView(title: title)
            
            LazyVGrid(columns: columns) {
                ForEach(mangaList) { manga in
                    mangaItemView(manga: manga, coverURL: coverURLProvider(manga))
                }
            }
        }
    }
}

private extension MangaSectionContainerView {
    func mangaItemView(manga: MangaData, coverURL: URL?) -> some View {
        MangaSingleGridView(
            title: manga.attributes.title.en ?? "Untitled",
            description: manga.attributes.tags.first?.attributes.name.en ?? "Unknown",
            coverURL: coverURL
        )
    }
}
