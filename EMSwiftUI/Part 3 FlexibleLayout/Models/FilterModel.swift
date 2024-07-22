//
//  FilterModel.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 18.07.2024.
//

import Foundation

struct FilterModel: Identifiable, Hashable {
    var id = UUID()
    let type: MangaType
    let tags: [String]
}
