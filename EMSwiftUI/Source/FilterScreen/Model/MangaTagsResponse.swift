//
//  TagModel.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 30.03.2025.
//

import Foundation

struct MangaTagsResponse: Decodable {
    let result: String
    let response: String
    let data: [Tag]
    let limit: Int
    let offset: Int
    let total: Int
}
