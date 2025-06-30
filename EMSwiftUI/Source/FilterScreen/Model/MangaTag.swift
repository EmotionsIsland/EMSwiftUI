//
//  MangaTag.swift
//  EMSwiftUI
//
//  Created by Ruslan on 25.06.2025.
//

struct MangaTagRepresentable: Identifiable, Hashable {
    let id: String
    let name: String
    var isSelected = false
    let group: TagGroup
}

enum TagGroup: String, Codable, CaseIterable {
    case content = "content"
    case format = "format"
    case genre = "genre"
    case theme = "theme"
}

