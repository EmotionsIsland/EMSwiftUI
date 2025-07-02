import Foundation
import SwiftUI

@MainActor
final class FilterTagViewModel: ObservableObject {
    @Published var allTags: [FilterTag] = []
    @Published var selectedTags: Set<FilterTag> = []
    @Published var groups: [FilterTagGroup] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let service: FilterTagServiceProtocol
    
    init(service: FilterTagServiceProtocol = FilterTagService()) {
        self.service = service
    }
    
    func fetchTags() async {
        isLoading = true
        error = nil
        do {
            let tags = try await service.fetchTags()
            allTags = tags
            groups = Dictionary(grouping: tags, by: { $0.group })
                .map { FilterTagGroup(id: $0.key, name: $0.key.capitalized, tags: $0.value) }
                .sorted { $0.name < $1.name }
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    func toggleTag(_ tag: FilterTag) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
    
    func reset() {
        selectedTags.removeAll()
    }
} 