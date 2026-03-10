//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import Foundation

@MainActor
final class FilterScreenViewModel: ObservableObject {
    @Published private(set) var sections: [FilterSection] = []
    @Published private(set) var allTagsByID: [String: FilterTag] = [:]
    @Published var selectedIDs: Set<String> = []

    private let service: FilterTagsServiceProtocol
    private let options: StaticFilterAttributesProtocol

    init(
        service: FilterTagsServiceProtocol,
        options: StaticFilterAttributesProtocol = StaticFilterAttributes()
    ) {
        self.service = service
        self.options = options
    }

    func load() async {
        do {
            let tags = try await service.fetchTags()
            proccesTags(tags)
        } catch {
            print("Filter tags load error:", error)
        }
    }
    
    private func proccesTags(_ tags: [FilterTag]) {
        let allTags = tags + options.staticTags
        
        allTagsByID = Dictionary(uniqueKeysWithValues: allTags.map { ($0.id, $0) })
        
        sections = buildSections(from: tags)
    }
    
    private func buildSections(from tags: [FilterTag]) -> [FilterSection] {
        let grouped = Dictionary(grouping: tags) { $0.group }
        
        var result = options.staticSections
        
        let apiSections = options.apiOrder
            .map {
                FilterSection(
                    filterTagGroup: $0,
                    isExpanded: false,
                    tags: grouped[$0] ?? []
                )
            }
            .filter { !$0.tags.isEmpty }
        
        result += apiSections
        
        if let other = grouped[.other], !other.isEmpty {
            result.append(
                FilterSection(
                    filterTagGroup: .other,
                    isExpanded: false,
                    tags: other
                )
            )
        }
        
        return result
    }

    func toggleSection(_ group: FilterTagGroup) {
        guard let idx = sections.firstIndex(where: { $0.filterTagGroup == group }) else { return }
        sections[idx].isExpanded.toggle()
    }

    func toggleTag(_ tag: FilterTag) {
        if selectedIDs.contains(tag.id) {
            selectedIDs.remove(tag.id)
        } else {
            selectedIDs.insert(tag.id)
        }
    }

    func isSelected(_ tag: FilterTag) -> Bool {
        selectedIDs.contains(tag.id)
    }

    func reset() {
        selectedIDs.removeAll()
    }

    var selectedTags: [FilterTag] {
        selectedIDs.compactMap { allTagsByID[$0] }
            .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
    }
}
