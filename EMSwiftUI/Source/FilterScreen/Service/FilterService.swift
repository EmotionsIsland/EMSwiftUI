//
//  FilterService.swift
//  EMSwiftUI
//
//  Created by Katerina Ivanova on 29.06.2025.
//

import Foundation
import Factory
import Netify

protocol FilterService: AnyObject {
    func getTags() async throws -> TagsListModel
}

final class FilterServiceImpl: FilterService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getTags() async throws -> TagsListModel {
        try await netify.request(API.mangaTags, type: TagsListModel.self)
    }
}
