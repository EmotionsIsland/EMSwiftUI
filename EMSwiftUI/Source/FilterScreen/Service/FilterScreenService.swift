//
//  FilterScreenService.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/15/25.
//

import Foundation
import Netify

protocol FilterScreenService {
    func fetchTags() async throws -> FilterScreenModel
}

final class FilterScreenServiceImpl: FilterScreenService {
    let netify: any Netify
    
    init(netify: any Netify) {
        self.netify = netify
    }
    
    func fetchTags() async throws -> FilterScreenModel {
        try await netify.request(API.mangaTags, type: FilterScreenModel.self)
    }
}
