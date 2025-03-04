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

extension MangaListModel{
    static let mock: MangaListModel =
    MangaListModel(
        result: "",
        response: "",
        data: [],
        limit: 0,
        offset: 0,
        total: 0)
}

struct MangaData: Decodable, Identifiable {
    let id: String
    let type: String
    let attributes: Attributes
    let relationships: [Relationship]
}

extension MangaData{
    static let mock: MangaData =
    MangaData(
        id: "",
        type: "",
        attributes: Attributes.mock,
        relationships: [])
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

extension Attributes{
    static let mock : Attributes =
    Attributes(
        title: Title(en: "Title Title Title Title Title Title Title"),
        altTitles: [],
        description: AttributesDescription(en: "Description Description Description Description", ru: "Описание Описание Описание Описание"),
        isLocked: false,
        originalLanguage: "",
        publicationDemographic: "",
        status: "status",
        year: 2025,
        contentRating: "4.5",
        tags: [],
        state: "",
        createdAt: "",
        updatedAt: "",
        version: 0,
        availableTranslatedLanguages: [])
}

struct Title: Decodable {
    let en: String?
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
