//
//  FilterService.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 31.03.2025.
//

import Foundation
import Netify

protocol FilterServiceProtocol {
    func fetchMangaTags() async throws -> MangaTagsResponse
}

final class FilterService: FilterServiceProtocol {
    let netify: Netify

    init(netify: Netify) {
        self.netify = netify
    }

    func fetchMangaTags() async throws -> MangaTagsResponse {
        return try await netify.request(API.mangaTags, type: MangaTagsResponse.self)
    }
}
