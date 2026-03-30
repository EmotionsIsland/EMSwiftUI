//
//  MangaListModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation

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
    let title: MangaTitle
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

struct Description: Decodable {
    let english: String?
    let jaRo: String?
}

struct AlternativeTitle: Decodable {
    let value: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dictionary = try container.decode([String: String].self)
        value = dictionary.values.first
    }
}

struct MangaTitle: Decodable {
    let english: String?
    let primary: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dictionary = try container.decode([String: String].self)
        english = dictionary["en"]
        primary = dictionary["en"] ?? dictionary.values.first
    }
}

struct AttributesDescription: Decodable {
    let english: String?
    let russian: String?
}

struct Relationship: Decodable {
    let id: String
    let type: String
    let attributes: CoverAttributes?
}

struct CoverAttributes: Decodable {
    let fileName: String
}
