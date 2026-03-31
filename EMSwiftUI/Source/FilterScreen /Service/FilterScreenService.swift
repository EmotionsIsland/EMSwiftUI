//
//  FilterScreenService.swift
//  EMSwiftUI
//
//  Created by Анатолий Чириков on 24.03.2026.
//

import Foundation
import Netify
import Factory

protocol FilterScreenService {
    func getTags() async throws -> TagListModel
}

final class FilterScreenServiceImpl: FilterScreenService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getTags() async throws -> TagListModel {
        try await netify.request(API.mangaTags, type: TagListModel.self  )
    }
}
