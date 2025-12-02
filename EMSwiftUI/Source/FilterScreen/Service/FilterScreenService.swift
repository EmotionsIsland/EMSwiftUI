import Foundation
import Netify

protocol FilterListService {
    func getTags() async throws -> FilterTagModel
}

final class FilterScreenServiceImpl: FilterListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getTags() async throws -> FilterTagModel {
        let endpoint = API.mangaTags
        let tags = try await netify.request(endpoint, type: FilterTagModel.self)
        return tags
    }
}
