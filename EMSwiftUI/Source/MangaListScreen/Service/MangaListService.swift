import SwiftUI
import Factory
import Netify

protocol MangaListService {
    func getManga() async throws -> MangaListModel
}

enum MangaListServiceError: Error {
    case urlError
    case imageError
}

final class MangaListServiceImpl: MangaListService {
    let netify: Netify
    
    init(netify: Netify) {
        self.netify = netify
    }
    
    func getManga() async throws -> MangaListModel {
        try await netify.request(API.mangaList, type: MangaListModel.self)
    }
}
