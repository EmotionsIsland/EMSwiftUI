struct FilterListModel: Decodable {
    let result: String
    let response: String
    let data: [Tag]
    let limit: Int
    let offset: Int
    let total: Int
}

struct Tag: Decodable, Identifiable, Hashable {
    let id: String
    let type: String
    let attributes: TagAttributes
}

struct TagAttributes: Decodable, Hashable {
    let name: Title
    let group: String
}
