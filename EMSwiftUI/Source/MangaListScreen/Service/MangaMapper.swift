//
//  MangaMapper.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 06.08.2026.
//

import Netify

protocol MangaMapper {
    func map(_ mangas: [MangaData]) -> [MangaModel]
}

final class MangaMapperImpl: MangaMapper {
    func map(_ mangas: [MangaData]) -> [MangaModel] {
        mangas.map { mangaData in
            let title = mangaData.attributes.title
            let altTitles = mangaData.attributes.altTitles

            return MangaModel(
                id: mangaData.id,
                coverUrl: API.coverURL(for: mangaData),
                title: title.en
                    ?? altTitles.compactMap { $0.en }.first
                    ?? title.ru
                    ?? altTitles.compactMap { $0.ru }.first
                    ?? title.jaRo
                    ?? altTitles.compactMap { $0.jaRo }.first
                    ?? "Missing title",
                genres: mangaData.attributes.tags
                    .filter { $0.attributes.group == "genre" }
                    .compactMap { $0.attributes.name.en }
            )
        }
    }
}
