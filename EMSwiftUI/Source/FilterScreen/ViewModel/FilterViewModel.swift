//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 18.02.2026.
//

import Foundation
import Netify

protocol FilterViewModel: ObservableObject {
    var selectedTagIds: Set<String> { get }
    func getSelectedTagsFormatted() -> [Tag]
    func getTags(for section: FilterSectionType) -> [Tag]
    func toggleTag(_ id: String, for section: FilterSectionType?)
    func reset()
}

extension FilterViewModel {
    func toggleTag(_ id: String) {
        toggleTag(id, for: nil)
    }
}

final class FilterViewModelImpl: FilterViewModel {
    @Published var remoteTags: [Tag] = []
    @Published var selectedTagIds: Set<String> = []
    
    private var selectedTags: [Tag] {
        allTags.filter { selectedTagIds.contains($0.id) }
    }

    private var allTags: [Tag] = []
    private var localTags: [Tag] = []
    private let service: FilterService

    init(service: FilterService) {
        self.service = service
        
        Task {
            try await getData()
        }
    }
    
// MARK: - Methods
    func getTags(for section: FilterSectionType) -> [Tag] {
        let prefix = section.idPrefix
        let localTags = localTags.filter {
            $0.id == "\(prefix)_any" || $0.id == "\(prefix)_none"
        }
        
        switch section {
        case .status:
            return getPublicationStatusTags() + localTags
        case .demographic:
            return getMagazineDemographicTags() + localTags
        default:
            let apiTags = remoteTags.filter { $0.attributes.group == section.apiKey }
            return apiTags + localTags
        }
    }
    
    func getSelectedTagsFormatted() -> [Tag] {
        return selectedTags
            .map { tag in
                let name = tag.attributes.name.en ?? ""
                if name == "Any" || name == "None" {
                    let groupName = tag.attributes.group.capitalized
                    let newName = "\(name) \(groupName)"
                    return createLocalTag(
                        id: tag.id,
                        name: newName,
                        group: tag.attributes.group
                    )
                }
                return tag
            }
            .sorted { ($0.attributes.name.en ?? "") < ($1.attributes.name.en ?? "") }
    }

    func toggleTag(_ id: String, for section: FilterSectionType? = nil) {
        if selectedTagIds.contains(id) {
            selectedTagIds.remove(id)
        } else {
            guard let section = section else { return }
            let prefix = section.idPrefix
            if id == "\(prefix)_any" || id == "\(prefix)_none" {
                selectedTagIds = selectedTagIds.filter { !$0.starts(with: "\(prefix)_") }
                if !section.apiKey.isEmpty {
                    selectedTagIds = selectedTagIds.filter { selectedId in
                        !remoteTags.contains(where: {
                            $0.id == selectedId && $0.attributes.group == section.apiKey
                        })
                    }
                }
            } else {
                selectedTagIds.remove("\(prefix)_any")
                selectedTagIds.remove("\(prefix)_none")
            }
            selectedTagIds.insert(id)
        }
    }
    
    func reset() {
        selectedTagIds.removeAll()
    }
    
    // MARK: - Service Methods
    @MainActor private func getData() async throws {
        do {
            let result = try await service.getTags()
            self.remoteTags = result.data
            self.localTags = getLocalTags()
            self.allTags = getAllTags()
        } catch {
            print("Ошибка загрузки: \(error)")
        }
    }
    
    // MARK: - Private Methods
    private func createLocalTag(id: String, name: String, group: String) -> Tag {
        Tag(
            id: id,
            type: "tag",
            attributes: TagAttributes(name: Title(en: name), group: group)
        )
    }
    
    private func getAllTags() -> [Tag] {
        var allTags: [Tag] = []
        allTags.append(contentsOf: remoteTags)
        allTags.append(contentsOf: localTags)
        return allTags
    }
    
    private func getLocalTags() -> [Tag] {
        var localTags: [Tag] = []
        localTags.append(contentsOf: getPublicationStatusTags())
        localTags.append(contentsOf: getMagazineDemographicTags())
        
        FilterSectionType.allCases.forEach { section in
            let prefix = section.idPrefix
            localTags.append(
                createLocalTag(
                    id: "\(prefix)_none",
                    name: "None",
                    group: section.rawValue
                )
            )
            localTags.append(
                createLocalTag(
                    id: "\(prefix)_any",
                    name: "Any",
                    group: section.rawValue
                )
            )
        }
        return localTags
    }
    
    private func getPublicationStatusTags() -> [Tag] {
        PublicationStatus.allCases.map {
            createLocalTag(
                id: "status_\($0.rawValue)",
                name: $0.rawValue.capitalized,
                group: "status"
            )
        }
    }
    
    private func getMagazineDemographicTags() -> [Tag] {
        MagazineDemographic.allCases.map {
            createLocalTag(
                id: "demographic_\($0.rawValue)",
                name: $0.rawValue.capitalized,
                group: "demographic"
            )
        }
    }
}
