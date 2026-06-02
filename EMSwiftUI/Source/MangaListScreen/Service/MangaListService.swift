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
    func mapToSectionItems(from data: [MangaData]) -> [MangaItem]
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }
    
    func mapToSectionItems(from data: [MangaData]) -> [MangaItem] {
        data.compactMap { manga in
            let title = manga.attributes.title.displayTitle
            
            let genres = manga.attributes.tags
                .map { $0.attributes.tagName }
                .joined(separator: ", ")
            
            let coverURL = API.coverURL(for: manga, .size256)
            
            let rating = CGFloat(Int.random(in: 35...49)) / 10
            
            return MangaItem(
                id: manga.id,
                title: title,
                genres: genres.isEmpty ? "No genres" : genres,
                coverURL: coverURL,
                rating: rating
            )
        }
    }
}
