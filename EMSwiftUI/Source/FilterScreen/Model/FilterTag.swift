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
    case contentRating
    case publicationDemographic
    case status
    case format
    case genre
    case theme
    case other

    var title: String {
        switch self {
        case .contentRating:
            return "Content rating"
        case .publicationDemographic:
            return "Publication demographic"
        case .status:
            return "Status"
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

extension FilterTag {
    static func contentRating(_ value: String, title: String? = nil) -> FilterTag {
        FilterTag(
            id: "contentRating:\(value)",
            title: title ?? value,
            group: .contentRating
        )
    }
    
    static func publicationDemographic(_ value: String, title: String? = nil) -> FilterTag {
        FilterTag(
            id: "publicationDemographic:\(value)",
            title: title ?? value,
            group: .publicationDemographic
        )
    }

    static func status(_ value: String, title: String? = nil) -> FilterTag {
        FilterTag(
            id: "status:\(value)",
            title: title ?? value,
            group: .status
        )
    }
}
