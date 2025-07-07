//
//  FilterScreenService.swift
//  EMSwiftUI
//
//  Created by Глеб Поляков on 06.07.2025.
//

import Foundation
import Factory
import Netify

protocol FilterScreenService {
    func getTags() async throws -> TagModel
}

final class FilterScreenServiceImpl: FilterScreenService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getTags() async throws -> TagModel {
        try await netify.request(API.mangaTags, type: TagModel.self)
    }
}
