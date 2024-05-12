import Foundation
import Combine

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

final class MangaListViewModel: ObservableObject {
    @Published var mangaList: MangaListModel?
    @Published var data: MangaData?
    @Published var state: DataState = .notAvailable
    @Published var hasError: Bool = false
    
    private var mangaService: MangaListServiceProtocol
    private var subs = Set<AnyCancellable>()
    
    
    init(service: MangaListServiceProtocol) {
        self.mangaService = service
        getManga()
        setupErrorSubscriptions()
    }
    
    private func getManga() {
        mangaService
            .getManga()
            .receive(on: OperationQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] mangaList in
                self?.mangaList = mangaList
                self?.state = .successfull
            }
            .store(in: &subs)
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
}

extension MangaListViewModel {
  func setupErrorSubscriptions() {
    $state
      .map { state -> Bool in
        switch state {
        case .successfull, .notAvailable:
          return false
        case .failed:
          return true
        }
      }
      .assign(to: &$hasError)
  }
}
