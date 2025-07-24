//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import Foundation
import Netify

protocol FilterViewModel: ObservableObject {
    var isLoading: Bool {get set}
    var navigationTitle: String {get set}
    var category: [String] {get set}
    var filterSelectionModel: FilterSelectionModel {get}
    func filterSectionModel(at category: String) -> FilterSectionModel
    @MainActor func getTags() async
}

final class FilterViewModelImpl: FilterViewModel {
    private let service: FilterService
    
    // published
    @Published var tag: FilterTagModel?
    @Published var tagsSelected: [Tag] = []
    @Published var isLoading = false
    @Published var category: [String] = ["Selection"]
    
    var filterSelectionModel: FilterSelectionModel {
        let title = category.first ?? "Selection"
        return FilterSelectionModel(
            category: title,
            selectedTags: tagsSelected,
            onTagSelect: { [weak self] tag in self?.changeStateTag(for: tag) },
            onReset: { [weak self] in self?.resetTags() }
        )
    }
    
    var navigationTitle = "Filters"
    
    init(service: FilterService) {
        self.service = service
    }
    
    // MARK: getTags
    @MainActor func getTags() async {
        isLoading = true
        do {
            let tag = try await service.getTags()
            
            await getCategory(from: tag)
            isLoading = false
            self.tag = tag
        } catch {
            isLoading = false
            print("\(error)")
        }
    }
    
    // MARK: getCategory
    @MainActor private func getCategory(from tag: FilterTagModel) async {
        var result: [String] = []
        var seen: Set<String> = []
        
        for item in tag.data {
            let category = item.attributes.group
            let formattedCategory = category.prefix(1).uppercased() + category.dropFirst()
            
            if !seen.contains(formattedCategory) {
                result.append(formattedCategory)
                seen.insert(formattedCategory)
            }
        }
        
        self.category += result
    }
    // MARK: filterCategory
    private func filterCategory(_ category: String) -> [Tag] {
        return tag?.data.filter { $0.attributes.group == category.lowercased() } ?? []
    }
    
    // MARK: changeStateTag
    private func changeStateTag(for tag: Tag) {
        if let index = tagsSelected.firstIndex(where: { $0.id == tag.id }) {
            self.tagsSelected.remove(at: index)
        } else {
            self.tagsSelected.append(tag)
        }
    }
    
    // MARK: resetTags
    private func resetTags() {
        tagsSelected = []
    }
    
    // MARK: filterSectionModel
    func filterSectionModel(at category: String) -> FilterSectionModel {
        let tags = filterCategory(category)
        let selectedStates = tags.map { tag in
            tagsSelected.contains(where: { $0.id == tag.id })
        }

        return FilterSectionModel(
            category: category,
            tags: tags,
            isSelected: selectedStates,
            onTagSelect: { [weak self] tag in
                self?.changeStateTag(for: tag)
            }
        )
    }
}
