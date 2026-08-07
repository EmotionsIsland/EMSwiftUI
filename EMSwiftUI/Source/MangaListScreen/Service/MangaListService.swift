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
    private let netify: Netify
    private let mapper: MangaMapper

    init(netify: Netify, mapper: MangaMapper) {
        self.netify = netify
        self.mapper = mapper
    }

    func getManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }

    func getManga(withOrder order: API.Order) async throws -> MangaListModel {
        try await netify.request(API.mangaList(withOrder: order), type: MangaListModel.self)
    }

    func getMangaModels(withOrder order: API.Order) async throws -> [MangaModel] {
        let data = try await getManga(withOrder: order).data
        return mapper.map(data)
    }
}
