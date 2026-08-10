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
    private let titleResolver: TitleResolver

    init(titleResolver: TitleResolver = TitleResolver()) {
        self.titleResolver = titleResolver
    }

    func map(_ mangas: [MangaData]) -> [MangaModel] {
        mangas.map { mangaData in
            let title = titleResolver.resolve(
                title: mangaData.attributes.title,
                alternativeTitles: mangaData.attributes.altTitles
            ) ?? "Missing title"
            let genres = mangaData.attributes.tags
                .filter { $0.attributes.group == "genre" }
                .compactMap { $0.attributes.name.en }
            return MangaModel(
                id: mangaData.id,
                coverUrl: API.coverURL(for: mangaData),
                title: title,
                genres: genres
            )
        }
    }
}
