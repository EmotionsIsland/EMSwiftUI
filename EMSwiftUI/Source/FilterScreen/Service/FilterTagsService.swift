import Foundation
import Factory
import Netify

protocol FilterTagsService {
    func fetchTags() async throws -> [Tag]
}

final class FilterTagsServiceImpl: FilterTagsService {
    private let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func fetchTags() async throws -> [Tag] {
        let response = try await netify.request(API.mangaTags, type: TagsResponse.self)
        return response.data
    }
}
