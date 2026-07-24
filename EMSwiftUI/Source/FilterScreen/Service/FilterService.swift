//
//  FilterService.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 23.07.2026.
//

import Netify

protocol FilterService {
    func getTags() async throws -> TagListModel
}

final class FilterServiceImpl: FilterService {
    let netify: Netify

    init(netify: Netify) {
        self.netify = netify
    }

    func getTags() async throws -> TagListModel {
        try await netify.request(API.mangaTags, type: TagListModel.self)
    }
}
