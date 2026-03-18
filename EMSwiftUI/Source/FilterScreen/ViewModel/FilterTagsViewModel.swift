import Foundation
import SwiftUI

protocol FilterTagsViewModel: ObservableObject {
    var selectedTags: [Tag] { get }
    var sections: [FilterSectionType: [Tag]] { get }
    var expandedSections: Set<FilterSectionType> { get }
    
    func load() async
    func toggleTag(_ tag: Tag)
    func isSelected(_ tag: Tag) -> Bool
    func reset()
    func apply()
    func toggleSection(_ section: FilterSectionType)
}

final class FilterTagsViewModelImpl: FilterTagsViewModel {
    @Published private(set) var selectedTags: [Tag] = []
    @Published private(set) var sections: [FilterSectionType: [Tag]] = [:]
    @Published private(set) var expandedSections: Set<FilterSectionType> = [.magazineDemographic]
    
    private let service: FilterTagsService
    
    init(service: FilterTagsService) {
        self.service = service
    }
    
    @MainActor
    func load() async {
        do {
            let tags = try await service.fetchTags()
            let grouped = Dictionary(grouping: tags, by: { FilterSectionType.from(group: $0.attributes.group) })
            
            var result: [FilterSectionType: [Tag]] = [:]
            for section in FilterSectionType.allCases {
                result[section] = grouped[section] ?? []
            }
            sections = result
        } catch {
            print("Failed to fetch tags: \(error)")
        }
    }
    
    func toggleTag(_ tag: Tag) {
        if let idx = selectedTags.firstIndex(where: { $0.id == tag.id }) {
            selectedTags.remove(at: idx)
        } else {
            selectedTags.append(tag)
        }
    }
    
    func isSelected(_ tag: Tag) -> Bool {
        selectedTags.contains(where: { $0.id == tag.id })
    }
    
    func reset() {
        selectedTags.removeAll()
    }
    
    func apply() {
        let names = selectedTags.compactMap { $0.attributes.name.english ?? $0.id }
        print("Apply with tags: \(names)")
    }
    
    func toggleSection(_ section: FilterSectionType) {
        if expandedSections.contains(section) {
            expandedSections.remove(section)
        } else {
            expandedSections.insert(section)
        }
    }
}
