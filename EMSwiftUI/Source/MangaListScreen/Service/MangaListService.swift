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
    func getTags() async throws -> [Tag]
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }
    
    func getTags() async throws -> [Tag] {
        struct TagResponse: Decodable {
            let data: [Tag]
        }
        
        let response = try await netify.request(API.mangaTags, type: TagResponse.self)
        return response.data
    }
}
