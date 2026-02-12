//
//  FilterTagsService.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import Foundation
import Netify

protocol FilterTagsServiceProtocol {
    func fetchTags() async throws -> [FilterTag]
}

final class FilterTagsService: FilterTagsServiceProtocol {
    private let netify: Netify

    init(netify: Netify) {
        self.netify = netify
    }

    func fetchTags() async throws -> [FilterTag] {
        let result = try await netify.request(API.mangaTags, type: MangaTagsResponse.self)

        return result.data.map { tag in
            let title = tag.attributes.name.en ?? "Unknown"
            let group = FilterTagGroup.from(apiGroup: tag.attributes.group)
            return FilterTag(id: tag.id, title: title, group: group)
        }
        .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
    }
}
