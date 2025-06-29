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
    weak var mangaProtocol: MangaSectionProtocol?
    
    let columns: [GridItem] = Array(
        repeating: GridItem(.flexible(minimum: 100, maximum: 100),
                            spacing: 25),
        count: 3
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MangaSectionTitleView(title: sectionTitle)
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 8
            ) {
                ForEach(mangaData, id: \.id) { manga in
                    MangaSingleGridView(
                        title: manga.attributes.title.en ?? manga.attributes.altTitles.first?.ru ?? "",
                        subtitle: manga.attributes.description.en ?? manga.attributes.description.ru ?? "",
                        rating: manga.attributes.rating,
                        coverURL: mangaProtocol?.getCoverURL(mangaData: manga, sizeFormat: .size512)
                    )
                }
            }
        }
    }
}
