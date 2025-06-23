struct TagListModel: Decodable {
    let result: String
    let response: String
    let data: [TagData]
}

struct TagData: Decodable, Identifiable, Hashable {
    let id: String
    let type: String
    let attributes: TagAttributes
}

struct TagAttributes: Decodable, Hashable {
    let name: Title
    let group: String
}
