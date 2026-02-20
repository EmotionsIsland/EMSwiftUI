//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 18.02.2026.
//

import Foundation
import Netify

protocol FilterViewModel: ObservableObject {
    var selectedTags: [Tag] { get }
    var selectedTagIds: Set<String> { get }
    func getTags(for section: FilterSectionType) -> [Tag]
    func toggleTag(_ id: String, for section: FilterSectionType?)
    func reset()
}

extension FilterViewModel {
    func toggleTag(_ id: String) {
        toggleTag(id, for: nil)
    }
}

enum FilterSectionType: String, CaseIterable {
    case contentRating = "Content Rating"
    case status = "Publication Status"
    case demographic = "Magazine Demographic"
    case format = "Format"
    case genre = "Genre"
    case theme = "Theme"
    
    var apiKey: String {
        switch self {
        case .contentRating: return "content"
        case .format: return "format"
        case .genre: return "genre"
        case .theme: return "theme"
        default: return ""
        }
    }
    
    var idPrefix: String {
        switch self {
        case .status: return "status"
        case .demographic: return "demographic"
        default:
            return apiKey.isEmpty
            ? self.rawValue.lowercased().replacingOccurrences(of: " ", with: "_")
            : apiKey
        }
    }
}

enum PublicationStatus: String, CaseIterable {
    case ongoing, completed, cancelled, hiatus
}

enum MagazineDemographic: String, CaseIterable {
    case shounen, shoujo, seinen, josei
}

final class FilterViewModelImpl: FilterViewModel {
    @Published var tags: [Tag] = []
    @Published var selectedTagIds: Set<String> = []
    
    var selectedTags: [Tag] {
        let allTags = tags + allLocalTags
        
        return allTags
            .filter { selectedTagIds.contains($0.id) }
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
    
    private var allPublicationStatusTags: [Tag] {
        PublicationStatus.allCases.map {
            createLocalTag(
                id: "status_\($0.rawValue)",
                name: $0.rawValue.capitalized,
                group: "status"
            )
        }
    }
    
    private var allMagazineDemographicTags: [Tag] {
        MagazineDemographic.allCases.map {
            createLocalTag(
                id: "demographic_\($0.rawValue)",
                name: $0.rawValue.capitalized,
                group: "demographic"
            )
        }
    }
    
    private var allLocalTags: [Tag] {
        var local: [Tag] = []
        local.append(contentsOf: allPublicationStatusTags)
        local.append(contentsOf: allMagazineDemographicTags)
        FilterSectionType.allCases.forEach { section in
            let prefix = section.idPrefix
            local.append(
                createLocalTag(
                    id: "\(prefix)_none",
                    name: "None",
                    group: section.rawValue
                )
            )
            local.append(
                createLocalTag(
                    id: "\(prefix)_any",
                    name: "Any",
                    group: section.rawValue
                )
            )
        }
        return local
    }

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
        let localTags = allLocalTags.filter {
            $0.id == "\(prefix)_any" || $0.id == "\(prefix)_none"
        }
        
        switch section {
        case .status:
            return allPublicationStatusTags + localTags
        case .demographic:
            return allMagazineDemographicTags + localTags
        default:
            let apiTags = tags.filter { $0.attributes.group == section.apiKey }
            return apiTags + localTags
        }
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
                        !tags.contains(where: {
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
    
    // MARK: - Private Methods
    @MainActor private func getData() async throws {
        do {
            let result = try await service.getTags()
            self.tags = result.data
        } catch {
            print("Ошибка загрузки: \(error)")
        }
    }
    
    private func createLocalTag(id: String, name: String, group: String) -> Tag {
        Tag(
            id: id,
            type: "tag",
            attributes: TagAttributes(name: Title(en: name), group: group)
        )
    }
}
