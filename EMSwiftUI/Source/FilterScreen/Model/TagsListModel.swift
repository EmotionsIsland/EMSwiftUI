//
//  TagsListModel.swift
//  EMSwiftUI
//
//  Created by Katerina Ivanova on 29.06.2025.
//

import Foundation

struct TagsListModel: Decodable {
    let result: String
    let response: String
    let data: [Tag]
    let limit: Int
    let offset: Int
    let total: Int
}

struct GroupedTags: Equatable {
    var id = UUID().uuidString
    var group: String
    var isExpanded: Bool
    var isRotating = 90.0
    var tags: [Tag]
}
