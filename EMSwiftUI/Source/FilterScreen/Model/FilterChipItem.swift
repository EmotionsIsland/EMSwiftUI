//
//  FilterChipItem.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import Foundation

struct FilterChipItem: Identifiable, Hashable {
    let id: String
    let title: String
    let group: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: FilterChipItem, rhs: FilterChipItem) -> Bool {
        lhs.id == rhs.id
    }
}
