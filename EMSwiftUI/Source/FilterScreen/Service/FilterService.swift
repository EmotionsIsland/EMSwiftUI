//
//  FilterService.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 12.05.2026.
//

import Foundation
import Netify

protocol FilterService {
    func getTags() async throws -> MangaTagsModel
}

final class FilterServiceImpl: FilterService {
    private let netify: Netify

    init(netify: Netify) {
        self.netify = netify
    }

    func getTags() async throws -> MangaTagsModel {
        try await netify.request(API.mangaTags, type: MangaTagsModel.self)
    }
}
