//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import Foundation
import Netify

protocol FilterViewModel: ObservableObject {
    var tag: FilterTagModel? {get set}
    var tagsSelected: [Tag] {get set}
    var isLoading: Bool {get set}
    var navigationTitle: String {get set}
    var category: [String] {get set}
    @MainActor func getTags() async
    func filterCategory(_ category: String) -> [Tag]
    func checkIsSelected(_ tags: [Tag]) -> [Bool]
    func changeStateTag(for tag: Tag)
}

final class FilterViewModelImpl: FilterViewModel {
    private let service: FilterService
    
    // published
    @Published var tag: FilterTagModel?
    @Published var tagsSelected: [Tag] = []
    @Published var isLoading = false
    @Published var category: [String] = ["Selection",
                                         "Content Rating",
                                         "Publication Status",
                                         "Magazine Demographic"]
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
    func filterCategory(_ category: String) -> [Tag] {
        return tag?.data.filter { $0.attributes.group == category.lowercased() } ?? []
    }
    
    // MARK: checkIsSelected
    func checkIsSelected(_ tags: [Tag]) -> [Bool] {
        return tags.map { tag in
            tagsSelected.contains(where: { $0.id == tag.id })
        }
    }
    
    // MARK: changeStateTag
    func changeStateTag(for tag: Tag) {
        if let index = tagsSelected.firstIndex(where: { $0.id == tag.id }) {
            self.tagsSelected.remove(at: index)
        } else {
            self.tagsSelected.append(tag)
        }
    }
}
