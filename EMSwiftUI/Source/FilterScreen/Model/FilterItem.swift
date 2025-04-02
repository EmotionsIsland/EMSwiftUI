//
//  FilterItem.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 31.03.2025.
//

import Foundation

struct FilterItem: Identifiable, Hashable {
    let id: String
    let category: FilterCategory
    let name: String
    var isSelected: Bool
}

extension FilterItem {
    init(_ tag: Tag) {
        id = tag.id
        category = FilterCategory(rawValue: tag.attributes.group) ?? .other
        name = tag.attributes.name.en ?? ""
        isSelected = false
    }
}
