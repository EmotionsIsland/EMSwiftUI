//
//  TagModel.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import Foundation

// swiftlint:disable identifier_name
struct TagModel: Decodable {
    let result, response: String
    let data: [TagData]
    let limit, offset, total: Int
}

struct TagData: Decodable {
    let id: String
    let type: String
    let attributes: Attributes

    struct Attributes: Decodable {
        let name: Name
        let group: String
        let version: Int
    }

    struct Name: Decodable {
        let en: String
    }
}
// swiftlint:enable identifier_name
