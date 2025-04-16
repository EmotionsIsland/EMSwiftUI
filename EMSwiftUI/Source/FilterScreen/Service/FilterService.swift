//
//  FilterService.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import Foundation
import Netify

protocol IFilterService {
    func getTags() async throws -> TagModel
}

final class FilterService: IFilterService {
    let netify: Netify

    init(netify: Netify) {
        self.netify = netify
    }

    func getTags() async throws -> TagModel {
        try await netify.request(API.mangaTags, type: TagModel.self)
    }
}
