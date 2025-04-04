import SwiftUI
import Factory
import Netify

protocol MangaListService {
    func getManga() async throws -> MangaListModel
    func fetchCover(for item: MangaListItem) async throws -> UIImage
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
        
    func fetchCover(for item: MangaListItem) async throws -> UIImage {
        guard let url = item.coverURL else {
            throw  MangaListServiceError.urlError
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: urlRequest)

        guard let image = UIImage(data: data) else {
            throw MangaListServiceError.imageError
        }

        return image
    }
}
