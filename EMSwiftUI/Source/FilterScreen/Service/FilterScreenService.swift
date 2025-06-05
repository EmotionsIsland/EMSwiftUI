//
//  FilterScreenService.swift
//  EMSwiftUI
//
//  Created by mm pechenbku on 03.06.2025.
//

import Netify

protocol FilterScreenServiceProtocol: AnyObject {
    func getFilters() async throws -> TagsListModel
}

final class FilterScreenService: FilterScreenServiceProtocol {
    // MARK: - Private properties

    private let netify: Netify

    // MARK: - Init

    init(netify: Netify) {
        self.netify = netify
    }

    // MARK: - Internal Methods

    func getFilters() async throws -> TagsListModel {
        return try await netify.request(API.mangaTags, type: TagsListModel.self)
    }
}
