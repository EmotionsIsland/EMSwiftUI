//
//  FilterService.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import Foundation
import Netify
import Factory

protocol FilterService {
    func getTags() async throws -> FilterTagModel
}

final class FilterServiceImpl: FilterService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    // MARK: getTags
    func getTags() async throws -> FilterTagModel {
        let endPoint = API.mangaTags
        let tags = try await netify.request(endPoint, type: FilterTagModel.self)
        
        return tags
    }
}
