import Foundation
import Netify

protocol FilterService {
    func fetchTags() async throws -> [Tag]
}

final class FilterServiceImpl: FilterService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func fetchTags() async throws -> [Tag] {
        let tags = try await netify.request(API.mangaTags, type: FilterListModel.self).data
        return tags
    }
}
