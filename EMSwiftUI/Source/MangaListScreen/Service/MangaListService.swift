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
    func getManga(withOrder order: API.Order) async throws -> MangaListModel
    func getMangaModels(withOrder order: API.Order) async throws -> [MangaModel]
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }

    func getManga(withOrder order: API.Order) async throws -> MangaListModel {
        try await netify.request(API.mangaList(withOrder: order), type: MangaListModel.self)
    }

    func getMangaModels(withOrder order: API.Order) async throws -> [MangaModel] {
        let data = try await getManga(withOrder: order).data
        return convertToMangaModel(data)
    }

    private func convertToMangaModel(_ mangas: [MangaData]) -> [MangaModel] {
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
