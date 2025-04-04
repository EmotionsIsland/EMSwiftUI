import SwiftUI
import Factory
import Netify
import Combine

protocol FilterScreenViewModel: ObservableObject {
    var hasError: Bool { get set }
    var errorMessage: String { get set }
    var items: [FilterItem] { get }
    var selectedItems: [FilterItem] { get }
    @MainActor func fetchItems() async
    @MainActor func getItems(for category: FilterCategory) -> [FilterItem]
    @MainActor func selectItem(_ item: FilterItem)
    @MainActor func applySelection()
    @MainActor func resetSelection()
}

final class FilterScreenViewModelImpl: FilterScreenViewModel {
    private let service: MangaTagService
    
    init(service: MangaTagService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    @Published var items: [FilterItem] = []
    var selectedItems: [FilterItem] {
        items.filter { $0.isSelected }
    }

    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var state: DataState = .notAvailable
    
    @MainActor
    func fetchItems() async {
        do {
            let response = try await service.getTag()
            self.items = response.data.map(FilterItem.init)
            self.state = .successfull
            print("DEBUG: Fetch data successfully")
        } catch {
            self.state = .failed(error: error)
            debugPrint("DEBUG: - Fetch data failed: \(error.localizedDescription)")
            print("DEBUG: - Fetch data ERROR")
        }
    }

    @MainActor
    func getItems(for category: FilterCategory) -> [FilterItem] {
        switch category {
        case .other:
            let other = FilterCategory.allCases.filter { $0 != .other }
            return items.filter { !other.contains($0.category) }
        default:
            return items.filter { $0.category == category }
        }
    }

    @MainActor
    func selectItem(_ item: FilterItem) {
        guard let index = items.firstIndex(where: {$0 == item }) else { return }
        items[index].isSelected.toggle()
    }

    @MainActor
    func applySelection() {
        var _ = self.selectedItems.map { $0.category.title }
    }

    @MainActor
    func resetSelection() {
        items = items.map { immutableItem in
            var item = immutableItem
            item.isSelected = false
            return item
        }
    }
}

private extension FilterScreenViewModelImpl {
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
