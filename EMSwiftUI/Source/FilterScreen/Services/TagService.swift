//
//  TagService.swift
//  EMSwiftUI
//
//  Created by Ruslan on 25.06.2025.
//

import Netify

protocol TagService {
    func loadTags() async throws -> MangaResponce
}

final class TagServiceImpl: TagService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func loadTags() async throws -> MangaResponce {
        try await netify.request(API.mangaTags, type: MangaResponce.self)
    }
}
