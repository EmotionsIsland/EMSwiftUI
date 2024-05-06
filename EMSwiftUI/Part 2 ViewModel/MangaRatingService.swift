import Foundation
import Combine

// Изначально хотел добавить этот метод в MangaListViewModel потом впомнил про 4 принцип солида и создал отдельный сервис
protocol MangaRatingServiceProtocol: AnyObject {
    var network: NetworkProtocol { get }
        
    func getRating(mangaId: String) -> AnyPublisher<RatingResponse, Error>
}

final class MangaRatingService: MangaRatingServiceProtocol {
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
}

extension MangaRatingService {
    func getRating(mangaId: String) -> AnyPublisher<RatingResponse, Error> {
        let endpoint = Endpoint(path: "/statistics/manga/" + mangaId)
        
        return network.getData(with: endpoint.url, RatingResponse.self)
    }
}
