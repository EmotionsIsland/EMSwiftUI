//
//  MangaDisplayData.swift
//  EMSwiftUI
//
//  Created by Анатолий Чириков on 07.04.2026.
//

import Foundation
import Netify

struct MangaItemUIModel: Identifiable {
    let id: String
    let title: String
    let converURL: URL?
    let tag: String
}

extension MangaItemUIModel {
    init(manga: MangaData) {
        self.id = manga.id
        self.title = manga.attributes.title.en
        ?? manga.attributes.altTitles.compactMap { $0.ru }.first
        ?? "No title"
        self.converURL = API.coverURL(for: manga, .size256)
        self.tag = manga.attributes.tags.first?.attributes.name.en ?? "Manga"
    }
}
