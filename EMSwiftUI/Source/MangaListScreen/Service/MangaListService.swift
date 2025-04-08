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
    func fetchManga() async throws -> MangaListModel
}

enum MangaListServiceError: Error {
    case urlError
    case imageDataDecodingError
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func fetchManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }
}
