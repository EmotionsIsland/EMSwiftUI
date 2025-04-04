import SwiftUI
import Factory
import Netify
import Combine

protocol FilterScreenViewModel: ObservableObject {
    var items: [FilterItem] { get }
    var selectedItems: [FilterItem] { get }
    @MainActor func fetchItems() async
    func getItems(for category: FilterCategory) -> [FilterItem]
    func selectItem(_ item: FilterItem)
    func applySelection()
    func resetSelection()
}

final class FilterScreenViewModelImpl: FilterScreenViewModel {
    @Published private(set) var items: [FilterItem] = []
    @Published private(set) var state: DataState = .notAvailable
    private let service: MangaTagService
    
    init(service: MangaTagService) {
        self.service = service
        Task { await fetchItems() }
    }
    
    var selectedItems: [FilterItem] {
        items.filter { $0.isSelected }
    }
    
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

    func getItems(for category: FilterCategory) -> [FilterItem] {
        switch category {
        case .other:
            let other = FilterCategory.allCases.filter { $0 != .other }
            return items.filter { !other.contains($0.category) }
        default:
            return items.filter { $0.category == category }
        }
    }

    func selectItem(_ item: FilterItem) {
        guard let index = items.firstIndex(where: {$0 == item }) else { return }
        items[index].isSelected.toggle()
    }

    func applySelection() {
        var _ = self.selectedItems.map { $0.category.title }
    }

    func resetSelection() {
        items = items.map { immutableItem in
            var item = immutableItem
            item.isSelected = false
            return item
        }
    }
}
