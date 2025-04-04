import SwiftUI
import Factory
import Netify

protocol MangaTagService {
    func getTag() async throws -> MangaTagsResponse
}

final class MangaTagServiceImpl: MangaTagService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getTag() async throws -> MangaTagsResponse {
        try await netify.request(API.mangaTags, type: MangaTagsResponse.self)
    }
}
