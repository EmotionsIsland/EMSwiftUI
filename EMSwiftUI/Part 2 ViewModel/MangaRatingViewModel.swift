import Foundation
import Combine

class MangaRatingViewModel: ObservableObject {
    @Published private(set) var average: Double = 0
    @Published private(set) var follows: Int = 0
    @Published private(set) var repliesCount: Int = 0
        
    private var subscribe: AnyCancellable? = nil

    private let service: MangaRatingService
    
    init(mangaId: String, service: MangaRatingService) {
        self.service = service
        getRating(mangaId: mangaId)
    }
    
    private func getRating(mangaId: String) {
       subscribe = service.getRating(mangaId: mangaId)
            .receive(on: DispatchQueue.main)
            .map { responce -> (Double, Int, Int) in
                let average = responce.statistics[mangaId]?.rating.average ?? 0
                let follows = responce.statistics[mangaId]?.follows ?? 0
                let repliesCount = responce.statistics[mangaId]?.comments.repliesCount ?? 0
                
                return (average, follows, repliesCount)
            }
            .sink { complition in
                switch complition {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] (average, follows, repliesCount) in
                self?.average = average
                self?.follows = follows
                self?.repliesCount = repliesCount
            }
    }
}
