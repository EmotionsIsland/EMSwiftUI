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
}
