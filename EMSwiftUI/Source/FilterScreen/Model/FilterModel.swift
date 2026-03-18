import Foundation

enum FilterSectionType: String, CaseIterable, Identifiable {
    case contentRating = "Content Rating"
    case publicationStatus = "Publication Status"
    case format = "Format"
    case genre = "Genre"
    case theme = "Theme"
    case magazineDemographic = "Magazine Demographic"
    
    var id: String { rawValue }
    
    static func from(group: String) -> FilterSectionType {
        switch group.lowercased() {
        case "content rating": return .contentRating
        case "publication status": return .publicationStatus
        case "format": return .format
        case "genre": return .genre
        case "theme": return .theme
        case "magazine demographic", "magazine_demographic", "demographic": return .magazineDemographic
        default:
            return .genre
        }
    }
}

struct TagsResponse: Decodable {
    let result: String?
    let data: [Tag]
}

struct Tag: Decodable, Identifiable {
    let id: String
    let type: String
    let attributes: TagAttributes
}

struct TagAttributes: Decodable {
    let name: Title
    let group: String
}

struct Title: Decodable {
    let english: String?

    enum CodingKeys: String, CodingKey {
        case english = "en" 
    }
}
