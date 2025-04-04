import Foundation

struct MangaTagsResponse: Decodable {
    let result: String
    let response: String
    let data: [Tag]
    let limit: Int
    let offset: Int
    let total: Int
}

struct FilterItem: Identifiable, Hashable {
    let id: String
    let category: FilterCategory
    let name: String
    var isSelected: Bool
}

extension FilterItem {
    init(_ tag: Tag) {
        id = tag.id
        category = FilterCategory(rawValue: tag.attributes.group) ?? .other
        name = tag.attributes.name.en ?? ""
        isSelected = false
    }
}

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
