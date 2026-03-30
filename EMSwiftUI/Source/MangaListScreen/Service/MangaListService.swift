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
    func getPopularManga() async throws -> MangaListModel
    func getRecentlyAddedManga() async throws -> MangaListModel
    func getLastUpdatedManga() async throws -> MangaListModel
    func getSeasonalManga() async throws -> MangaListModel
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getPopularManga() async throws -> MangaListModel {
        try await netify.request(mangaEndpoint(orderKey: "followedCount"), type: MangaListModel.self)
    }

    func getRecentlyAddedManga() async throws -> MangaListModel {
        try await netify.request(mangaEndpoint(orderKey: "createdAt"), type: MangaListModel.self)
    }

    func getLastUpdatedManga() async throws -> MangaListModel {
        try await netify.request(mangaEndpoint(orderKey: "updatedAt"), type: MangaListModel.self)
    }

    func getSeasonalManga() async throws -> MangaListModel {
        let currentYear = String(Calendar.current.component(.year, from: .now))
        return try await netify.request(
            mangaEndpoint(
                orderKey: "followedCount",
                extraQueryItems: [URLQueryItem(name: "year", value: currentYear)]
            ),
            type: MangaListModel.self
        )
    }

    private func mangaEndpoint(orderKey: String, extraQueryItems: [URLQueryItem] = []) -> Endpoint {
        let queryItems = [
            URLQueryItem(name: "limit", value: "6"),
            URLQueryItem(name: "contentRating[]", value: "safe"),
            URLQueryItem(name: "order[\(orderKey)]", value: "desc"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ] + extraQueryItems

        return API.api.endpoint(path: "/manga", queryItems: queryItems)
    }
}
