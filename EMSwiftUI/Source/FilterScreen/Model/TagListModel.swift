//
//  TagListModel.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 24.07.2026.
//

struct TagListModel: Decodable {
    let result: String
    let response: String
    let data: [Tag]
    let limit: Int
    let offset: Int
    let total: Int
}
