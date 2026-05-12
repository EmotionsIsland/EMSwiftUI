//
//  MangaListService.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Factory
import Netify

protocol MangaListService {
    func getManga() async throws -> MangaListModel
    func getSectionItems(from data: [MangaData]) -> [MangaItem]
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    private let placeholderRating: CGFloat = 4.2

    init(netify: Netify) {
        self.netify = netify
    }
    
    func getManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }

    func getSectionItems(from data: [MangaData]) -> [MangaItem] {
        return data.compactMap { mapItem(from: $0) }
    }
}

private extension MangaListServiceImpl {
    func mapItem(from data: MangaData) -> MangaItem? {
        guard let title = data.attributes.title.displayTitle else {
            return nil
        }

        let genres = data.attributes.tags
            .compactMap { $0.attributes.name.displayTitle ?? $0.attributes.name.en }
            .joined(separator: ", ")

        let coverFileName = data.relationships
            .first(where: { $0.type == "cover_art" })?
            .attributes?.fileName

        let coverURL = makeCoverURL(
            mangaId: data.id,
            fileName: coverFileName
        )

        return MangaItem(
            id: data.id,
            title: title,
            genres: genres,
            coverURL: coverURL,
            rating: placeholderRating
        )
    }

    func makeCoverURL(
        mangaId: String,
        fileName: String?,
        size: SizeFormat = .size256
    ) -> URL? {
        guard let fileName else { return nil }
        let path = "\(fileName)\(size.rawValue)"
        return URL(string: "https://uploads.mangadex.org/covers/\(mangaId)/\(path)")
    }
}
