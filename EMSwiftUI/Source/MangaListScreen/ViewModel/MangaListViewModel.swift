import SwiftUI
import Netify
import Combine

protocol MangaListViewModel: ObservableObject {
    var hasError: Bool { get }
    var searchText: String { get set }
    var errorMessage: String { get }
    var filteredMangaList: [MangaListItem] { get }
    @MainActor func fetchItems() async
    func dismissError()
}

final class MangaListViewModelImpl: MangaListViewModel {
    private let service: MangaListService
    @Published var searchText = ""
    @Published private(set) var errorMessage = ""
    @Published private(set) var hasError = false
    @Published private(set) var itemsManga: [MangaListItem] = []
    @Published private(set) var filteredMangaList: [MangaListItem] = []
    @Published private(set) var state: DataState = .notAvailable
    
    init(service: MangaListService) {
        self.service = service
        Task { await fetchItems() }
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
    func dismissError() {
        hasError = false
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
