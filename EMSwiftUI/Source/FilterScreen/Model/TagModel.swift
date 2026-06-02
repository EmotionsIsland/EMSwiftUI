//
//  TagModel.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import Foundation

struct MangaTagsResponse: Decodable {
    let data: [TagDTO]
}

struct TagDTO: Decodable, Identifiable {
    let id: String
    let attributes: TagAttributesDTO
}

struct TagAttributesDTO: Decodable {
    let name: MultiLanguageName
    let group: String
}

struct MultiLanguageName: Decodable {
    // swiftlint:disable:next identifier_name
    let en: String?
}

extension MultiLanguageName {
    var displayValue: String {
        en ?? "unknown"
    }
}
