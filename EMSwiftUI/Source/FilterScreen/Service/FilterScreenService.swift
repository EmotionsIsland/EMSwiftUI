//
//  FilterScreenService.swift
//  EMSwiftUI
//
//  Created by Pavel Plyago on 24.07.2025.
//
import Foundation
import Factory
import Netify

protocol TagService {
    func getTag() async throws -> TagListModel
}

final class FilterScreenServiceImpl: TagService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getTag() async throws -> TagListModel {
        try await netify.request(API.mangaTags, type: TagListModel.self)
    }
}
