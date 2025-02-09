import Foundation
import Combine

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

final class MangaListViewModel: ObservableObject {
    @Published var mangaData: [MangaData] = []
    
    private let service: MangaListServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: MangaListServiceProtocol) {
        self.service = service
        fetchManga()
    }

    func fetchManga() {
        service.getManga()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Ошибка загрузки: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.mangaData = response.data
            })
            .store(in: &cancellables)
    }
    
    func getManga(by id: String) -> MangaData? {
        return mangaData.first { $0.id == id }
    }

    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else {
            return URL(string: "")!
        }
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }

    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
}
