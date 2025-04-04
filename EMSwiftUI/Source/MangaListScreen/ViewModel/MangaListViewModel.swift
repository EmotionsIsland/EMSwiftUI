import SwiftUI
import Netify
import Combine

protocol MangaListViewModel: ObservableObject {
    var hasError: Bool { get set }
    var searchText: String { get set }
    var errorMessage: String { get set }
    var filteredMangaList: [MangaListItem] { get }
    @MainActor func fetchItems() async
}

final class MangaListViewModelImpl: MangaListViewModel {
    private let service: MangaListService
    @Published var searchText: String = ""
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var itemsManga: [MangaListItem] = []
    @Published var filteredMangaList: [MangaListItem] = []
    @Published var state: DataState = .notAvailable
    
    init(service: MangaListService) {
        self.service = service
        setupErrorSubscriptions()
        setupSearchFilterSubscriptions()
    }
}

extension MangaListViewModelImpl {
    @MainActor
    func fetchItems() async {
        do {
            let response = try await service.getManga()
            self.itemsManga = response.data.map(MangaListItem.init)
            self.state = .successfull
        } catch {
            self.state = .failed(error: error)
            debugPrint("Fetch data failed: \(error.localizedDescription)")
        }
    }
}

private extension MangaListViewModelImpl {
    func setupErrorSubscriptions() {
        $state
            .map { [weak self] state -> Bool in
                switch state {
                case .successfull, .notAvailable:
                    return false
                case .failed(let error):
                    self?.errorMessage = error.localizedDescription
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}

private extension MangaListViewModelImpl {
    func setupSearchFilterSubscriptions() {
        $searchText
            .combineLatest($itemsManga)
            .map { searchText, mangaList in
                guard !searchText.isEmpty else { return mangaList }
                return mangaList.filter { manga in
                    manga.title.lowercased().contains(searchText.lowercased())
                }
            }
            .assign(to: &$filteredMangaList)
    }
}
