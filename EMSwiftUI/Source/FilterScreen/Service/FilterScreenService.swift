//
//  MangaListService.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Factory
import Netify

protocol FilterScreenService {
    func getMangaTags() async throws -> TagListModel
}

final class FilterScreenServiceImpl: FilterScreenService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getMangaTags() async throws -> TagListModel {
        try await netify.request(API.mangaTags, type: TagListModel.self)
    }
}
