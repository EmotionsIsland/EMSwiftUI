import Foundation

struct FilterTagModel: Decodable {
    let result: String
    let response: String
    let data: [Tag]
}
