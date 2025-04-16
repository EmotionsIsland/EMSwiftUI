//
//  TagItem.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import Foundation

struct TagItem: Hashable {
    let id = UUID()
    let text: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
