//
//  MangaResponce.swift
//  EMSwiftUI
//
//  Created by Ruslan on 25.06.2025.
//

import Foundation
// MARK: - MangaResponce
struct MangaResponce: Codable {
    let result, response: String
    let data: [Datum]
    let limit, offset, total: Int
    }

// MARK: - Datum
struct Datum: Codable {
    let id: String
    let attributes: Attributes
}

extension Datum {
// MARK: - Attributes
    struct Attributes: Codable {
        let name: Name
        let group: TagGroup
    }
    
// MARK: - Name
    struct Name: Codable {
        let en: String
    }
}
