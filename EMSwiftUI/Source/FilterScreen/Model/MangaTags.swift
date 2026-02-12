//
//  MangaTagsDTO.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import Foundation

// swiftlint:disable identifier_name
struct MangaTagsResponse: Decodable {
    let data: [MangaTag]
}

struct MangaTag: Decodable, Identifiable {
    let id: String
    let type: String
    let attributes: MangaTagAttributes
}

struct MangaTagAttributes: Decodable {
    let name: LocalizedString
    let group: String?
}

struct LocalizedString: Decodable {
    let en: String?
}
// swiftlint:enable identifier_name
