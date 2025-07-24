//
//  FilterSelectionModel.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 24/07/2025.
//

import Foundation

struct FilterSelectionModel {
    let category: String
    let selectedTags: [Tag]
    let onTagSelect: (Tag) -> Void
    let onReset: () -> Void
}
