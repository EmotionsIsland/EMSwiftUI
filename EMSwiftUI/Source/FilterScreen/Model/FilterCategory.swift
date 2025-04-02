//
//  FilterCategory.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 31.03.2025.
//

import Foundation

enum FilterCategory: String, CaseIterable {
    case format
    case genre
    case theme
    case other

    var title: String {
        switch self {
        case .format:
            return "Format"
        case .genre:
            return "Genre"
        case .theme:
            return "Theme"
        case .other:
            return "Other"
        }
    }
}
