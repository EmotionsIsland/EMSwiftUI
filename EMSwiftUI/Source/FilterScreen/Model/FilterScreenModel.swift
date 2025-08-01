//
//  FilterScreenModel.swift
//  EMSwiftUI
//
//  Created by Pavel Plyago on 24.07.2025.
//

import Foundation

// swiftlint:disable identifier_name
struct TagListModel: Decodable {
    let result, response: String
    let data: [TagDatum]
    let limit, offset, total: Int
}

struct TagDatum: Decodable, Identifiable {
    let id: String
    let type: String
    let attributes: TagAttributesModel
}

struct TagAttributesModel: Decodable {
    let name: Name
    let description: TagDescription
    let group: String
    let version: Int
}

struct TagDescription: Decodable {
    let en: String?
    let ru: String?
}

struct Name: Decodable {
    let en: String
}

struct TagDisplayItem: Identifiable, Hashable {
    let id: String
    let name: String
    let group: String
    var isSelected: Bool
    
    init(from tag: TagDatum) {
        self.id = tag.id
        self.name = tag.attributes.name.en
        self.group = tag.attributes.group
        self.isSelected = false
    }
}

struct TagSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [TagDisplayItem]
}

// swiftlint:enable identifier_name
