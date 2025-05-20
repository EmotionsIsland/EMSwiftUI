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

class FilterViewModelImpl: FilterViewModel {
    private let service: FilterService
    @Published var tags: [Tag] = []
    @Published var selectedTags: [Tag] = []
    var isLoading: Bool = false
    var groupedTags: [String: [Tag]] {
        Dictionary(grouping: tags, by: { $0.attributes.group })
    }
    
    init(service: FilterService) {
        self.service = service
    }
    
    @MainActor func loadTags() async throws {
        tags = try await service.fetchTags()
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
