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
    func getCover(for manga: MangaData) async throws -> Data
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }
    
    func getCover(for manga: MangaData) async throws -> Data {
        guard let url = API.coverURL(for: manga) else {
            print("An error occured while creating URL for cover")
            throw NetworkError.invalidURL()
        }
        
        return try await URLSession.shared.data(from: url).0
    }
}
