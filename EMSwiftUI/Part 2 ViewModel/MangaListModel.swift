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

extension MangaData {
    
    public static var mock: MangaData {
        MangaData(id: "1234",
                  type: "Manga",
                  attributes: .init(
                    title: .init(en: "Monster"),
                    altTitles: [],
                    description: .init(en: "",
                                       ru: nil),
                    isLocked: false,
                    originalLanguage: "",
                    publicationDemographic: "",
                    status: "",
                    year: 2005,
                    contentRating: "",
                    tags: [.init(id: "1234",
                                 type: "Type",
                                 attributes: .init(name: .init(en: "Tag"),
                                                                            group: "Group"))],
                    state: "",
                    createdAt: "",
                    updatedAt: "",
                    version: 4,
                    availableTranslatedLanguages: []),
                  relationships: [])
    }
    
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
