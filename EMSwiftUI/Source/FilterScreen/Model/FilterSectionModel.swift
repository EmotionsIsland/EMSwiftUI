//
//  FilterSectionModel.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 24/07/2025.
//

import Foundation

struct FilterSectionModel {
    let category: String
    let tags: [Tag]
    let isSelected: [Bool]
    let onTagSelect: (Tag) -> Void
}
