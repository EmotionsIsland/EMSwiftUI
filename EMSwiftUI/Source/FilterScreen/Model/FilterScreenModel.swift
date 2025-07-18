//
//  TagModel.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/15/25.
//

import Foundation

struct FilterScreenModel: Decodable {
    var data: [Tag]
}

struct SingleTagModel: Hashable, Identifiable {
    let id: String
    let title: String
    let group: String
}

struct GroupModel: Identifiable, Hashable {
    let id = UUID().uuidString
    let title: String
    var tags: [SingleTagModel]
    var isUnfolded = false
}
