//
//  DropDownMenuModel.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import Foundation

struct DropDownMenuModel: Hashable {
    let title: String
    let tagElements: [TagItem]
}

extension DropDownMenuModel {
    static let mock: [Self] = [
        .init(title: "Content Rating", tagElements: TagItem.mock),
        .init(title: "Genre", tagElements: TagItem.mock2),
        .init(title: "Platform", tagElements: TagItem.mock3),
        .init(title: "Language", tagElements: TagItem.mock4),
        .init(title: "Region", tagElements: TagItem.mock5),
        .init(title: "Publisher", tagElements: TagItem.mock6),
        .init(title: "Developer", tagElements: TagItem.mock7)
    ]
}
