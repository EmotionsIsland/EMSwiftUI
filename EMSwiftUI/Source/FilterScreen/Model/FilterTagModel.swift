import Foundation

struct FilterTag: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let group: String
}

struct FilterTagGroup: Identifiable, Hashable {
    let id: String
    let name: String
    var tags: [FilterTag]
}

struct FilterTagAPIResponse: Codable {
    let data: [FilterTagAPIData]
}

struct FilterTagAPIData: Codable {
    let id: String
    let attributes: FilterTagAttributes
}

struct FilterTagAttributes: Codable {
    let name: [String: String]
    let group: String
}
