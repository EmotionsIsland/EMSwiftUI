import SwiftUI

protocol FilterViewModel: ObservableObject {
    var tags: [Tag] { get }
    var selectedTags: [Tag] { get }
    var groupedTags: [String: [Tag]] { get }
    func loadTags() async throws
    func toggleSelection(for tag: Tag)
    func resetSelection()
    func isSelected(_ tag: Tag) -> Bool
    func applySelection()
}

final class FilterViewModelImpl: FilterViewModel {
    private let service: FilterService
    @Published private(set) var tags: [Tag] = []
    @Published private(set) var selectedTags: [Tag] = []
    var isLoading = false
    var groupedTags: [String: [Tag]] {
        Dictionary(grouping: tags, by: { $0.attributes.group })
    }
    
    init(service: FilterService) {
        self.service = service
    }
    
    func loadTags() async throws {
        let fetched = try await service.fetchTags().data
        await MainActor.run {
            self.tags = fetched
        }
    }
    
    func toggleSelection(for tag: Tag) {
        if selectedTags.contains(where: { $0.id == tag.id }) {
            selectedTags.removeAll { $0.id == tag.id }
        } else {
            selectedTags.append(tag)
        }
    }
    
    func resetSelection() {
        selectedTags.removeAll()
    }
    
    func isSelected(_ tag: Tag) -> Bool {
        selectedTags.contains(where: { $0.id == tag.id })
    }
    
    func applySelection() {}
}
