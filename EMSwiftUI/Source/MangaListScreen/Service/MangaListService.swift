//
//  MangaListService.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Netify

protocol MangaListService {
    func getManga() async throws -> MangaListModel
    func getTags() async throws -> TagResponse
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }
    
    func getTags() async throws -> TagResponse {
            try await netify.request(API.mangaTags, type: TagResponse.self)
    }
}
