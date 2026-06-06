//
//  MangaListModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation

// swiftlint:disable identifier_name
struct MangaListModel: Decodable {
    let result: String
    let response: String
    let data: [MangaData]
    let limit: Int
    let offset: Int
    let total: Int
}

struct MangaData: Decodable, Identifiable {
    let id: String
    let type: String
    let attributes: Attributes
    let relationships: [Relationship]
}

struct Attributes: Decodable {
    let title: Title
    let altTitles: [AlternativeTitle]
    let description: AttributesDescription
    let isLocked: Bool
    let originalLanguage: String
    let publicationDemographic: String?
    let status: String
    let year: Int?
    let contentRating: String
    let tags: [Tag]
    let state: String
    let createdAt: String
    let updatedAt: String
    let version: Int
    let availableTranslatedLanguages: [String?]
}

struct Title: Decodable {
    let values: [String: String]
        
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        values = try container.decode([String: String].self)
    }
    
    var displayTitle: String {
        if let en = values["en"], !en.isEmpty { return en }
        if let ru = values["ru"], !ru.isEmpty { return ru }
        return values.first?.value ?? "Untitled"
    }
}

struct Description: Decodable {
    let en: String?
    let jaRo: String?
}

struct AlternativeTitle: Decodable {
    let ru: String?
}

struct AttributesDescription: Decodable {
    let en: String?
    let ru: String?
}

struct Tag: Decodable, Identifiable {
    let id: String
    let type: String
    let attributes: TagAttributes
}

struct TagAttributes: Decodable {
    let name: Title
    let group: String
}

struct Relationship: Decodable {
    let id: String
    let type: String
    let attributes: CoverAttributes?
}

struct CoverAttributes: Decodable {
    let fileName: String
}

extension TagAttributes {
    var tagName: String {
        name.displayTitle
    }
}
// swiftlint:enable identifier_name
