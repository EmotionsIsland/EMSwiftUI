//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import Foundation

final class FilterScreenViewModel: ObservableObject {
    @Published private(set) var sections: [FilterSection] = []
    @Published private(set) var allTagsByID: [String: FilterTag] = [:]
    @Published var selectedIDs: Set<String> = []

    private let service: FilterTagsServiceProtocol

    init(service: FilterTagsServiceProtocol) {
        self.service = service
    }

    @MainActor func load() async {
        do {
            let tags = try await service.fetchTags()
            allTagsByID = Dictionary(uniqueKeysWithValues: tags.map { ($0.id, $0) })

            let grouped = Dictionary(grouping: tags, by: { $0.group })
            sections = FilterTagGroup.allCases
                .filter { $0 != .other }
                .map { group in
                    FilterSection(id: group, isExpanded: false, tags: grouped[group] ?? [])
                }
                .filter { !$0.tags.isEmpty }

            if let other = grouped[.other], !other.isEmpty {
                sections.append(FilterSection(id: .other, isExpanded: false, tags: other))
            }
        } catch {
            print("Filter tags load error:", error)
        }
    }

    func toggleSection(_ group: FilterTagGroup) {
        guard let idx = sections.firstIndex(where: { $0.id == group }) else { return }
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
