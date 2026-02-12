//
//  FilterTag.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import Foundation

struct FilterTag: Identifiable, Hashable {
    let id: String
    let title: String
    let group: FilterTagGroup
}

enum FilterTagGroup: String, CaseIterable, Hashable {
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

    static func from(apiGroup: String?) -> FilterTagGroup {
        guard let apiGroup else { return .other }
        return FilterTagGroup(rawValue: apiGroup) ?? .other
    }
}
