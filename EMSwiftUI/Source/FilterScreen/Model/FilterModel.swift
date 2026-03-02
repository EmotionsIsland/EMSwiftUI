//
//  FilterModel.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 18.02.2026.
//

import Foundation

struct FilterModel: Decodable {
    let result: String
    let response: String
    let data: [Tag]
    let limit: Int
    let offset: Int
    let total: Int
}

enum FilterSectionType: String, CaseIterable {
    case contentRating = "Content Rating"
    case status = "Publication Status"
    case demographic = "Magazine Demographic"
    case format = "Format"
    case genre = "Genre"
    case theme = "Theme"
    
    var apiKey: String {
        switch self {
        case .contentRating: return "content"
        case .format: return "format"
        case .genre: return "genre"
        case .theme: return "theme"
        default: return ""
        }
    }
    
    var idPrefix: String {
        switch self {
        case .status: return "status"
        case .demographic: return "demographic"
        default:
            return apiKey.isEmpty
            ? self.rawValue.lowercased().replacingOccurrences(of: " ", with: "_")
            : apiKey
        }
    }
}

enum PublicationStatus: String, CaseIterable {
    case ongoing, completed, cancelled, hiatus
}

enum MagazineDemographic: String, CaseIterable {
    case shounen, shoujo, seinen, josei
}
