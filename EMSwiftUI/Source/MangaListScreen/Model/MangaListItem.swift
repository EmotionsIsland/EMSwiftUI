//
//  MangaListItem.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 31.03.2025.
//

import Foundation
import Netify

struct MangaListItem: Identifiable {
    let id: String
    let title: String
    let coverURL: URL?
    let genres: [String]
}

extension MangaListItem {
    init(_ mangaData: MangaData) {
        id = mangaData.id
        coverURL = API.coverURL(for: mangaData)
        title = mangaData.attributes.title.en ?? "Manga Title"
        genres = mangaData.attributes.tags
            .filter { $0.attributes.group == "genre" }
            .compactMap { $0.attributes.name.en }
    }
}
