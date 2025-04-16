//
//  TagModel.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import Foundation

// swiftlint:disable identifier_name
struct TagModel: Codable {
    let result, response: String
    let data: [TagData]
    let limit, offset, total: Int
}

struct TagData: Codable {
    let id: String
    let type: TypeEnum
    let attributes: Attributes

    struct Attributes: Codable {
        let name: Name
        let group: String
        let version: Int

        struct Name: Codable {
            let en: String
        }
    }

    enum TypeEnum: String, Codable {
        case tag = "tag"
    }
}
// swiftlint:enable identifier_name
