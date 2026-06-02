//
//  TagService.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import Foundation
import Netify

protocol TagService {
    func fetchTags() async throws -> [TagDTO]
}

final class TagServiceImpl: TagService {
    private let netify: Netify

    init(netify: Netify) {
        self.netify = netify
    }

    func fetchTags() async throws -> [TagDTO] {
        let response: MangaTagsResponse = try await netify.request(API.mangaTags, type: MangaTagsResponse.self)
        return response.data
    }
}
