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
    func downloadCoverImage(mangaData: MangaData, size: SizeFormat) async throws -> Data
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    // MARK: getManga
    func getManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }
    
    // MARK: downloadCoverImage
    func downloadCoverImage(mangaData: MangaData, size: SizeFormat = .size512) async throws -> Data {
        guard let fileName = mangaData.relationships.first(where: { $0.type == "cover_art" })?.attributes?.fileName else {
            throw URLError(.badURL)
        }
        let endpoint = API.coverURL.endpoint(path: "/covers/\(mangaData.id)/\(fileName)\(size.rawValue)",
                                             headers: [:])
        
        let data = try await netify.requestRawData(endpoint)
       
        return data
    }
}
