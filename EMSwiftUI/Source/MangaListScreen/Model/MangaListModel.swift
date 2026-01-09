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
// swiftlint:enable identifier_name

extension MangaData {
    var displayTitle: String {
        if let enTitle = attributes.title.en, !enTitle.isEmpty {
            return enTitle
        }
        
        if let ruTitle = attributes.altTitles.first {
            return ruTitle.ru ?? "Без имени"
        }
        
        return "манга №\(id)"
    }
    
    var genres: [String] {
         attributes.tags
             .filter { $0.attributes.group == "genre" }
             .compactMap { $0.attributes.name.en }
     }
     
     // Строка с жанрами через запятую
     var genresString: String {
         genres.joined(separator: ", ")
     }
}
