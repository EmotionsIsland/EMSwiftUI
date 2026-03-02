//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Netify

struct MangaSectionView: View {
    var title: String
    var mangaList: [MangaData]
    
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 25),
        count: 3
    )
    
    var body: some View {
        VStack(spacing: 16) {
            MangaSectionTitleView(title: title)
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(mangaList) { manga in
                    MangaSingleGridView(
                        imageURL: API.coverURL(for: manga, .size256),
                        title: manga.attributes.title.en
                            ?? manga.attributes.altTitles.compactMap { $0.ru }.first
                            ?? "",
                        rating: 3.5,
                        tags: manga.attributes.tags.first?.attributes.name.en ?? ""
                    )
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
