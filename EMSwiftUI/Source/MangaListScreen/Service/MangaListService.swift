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
    func getManga(sort: MangaSort) async throws -> MangaListModel
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getManga(sort: MangaSort) async throws -> MangaListModel {
        try await netify.request(
            API.mangaList(sort: sort),
            type: MangaListModel.self
        )
    }
}
