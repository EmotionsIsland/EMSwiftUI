//
//  FilterModel.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 29.04.2026.
//

struct MangaTagsModel: Decodable {
    let result: String
    let response: String
    let data: [Tag]
    let limit: Int
    let offset: Int
    let total: Int
}

struct FilterTagItem: Identifiable, Hashable {
    let id: String
    let title: String
    let group: String
}
