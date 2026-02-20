//
//  FilterService.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 18.02.2026.
//

import Foundation
import Factory
import Netify

protocol FilterService {
    func getTags() async throws -> FilterModel
}

final class FilterServiceImpl: FilterService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getTags() async throws -> FilterModel {
        try await netify.request(API.mangaTags, type: FilterModel.self)
    }
}
