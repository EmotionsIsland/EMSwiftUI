//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Pavel Plyago on 24.07.2025.
//

import Foundation
import Combine
import Netify

protocol TagViewModel: ObservableObject {
    var sections: [(group: String, tags: [TagDisplayItem])] { get }
    var selectedTags: [TagDisplayItem] { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    func fetchDataTags() async
    func toggleTag(_ tag: TagDisplayItem)
    func reset()
}

final class TagViewModelImpl: ObservableObject, TagViewModel {
    @Published var sections: [(group: String, tags: [TagDisplayItem])] = []
    @Published var selectedTags: [TagDisplayItem] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private let service: TagService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: TagService) {
        self.service = service
        
        Task { await fetchDataTags() }
    }
    
    @MainActor
    private func getTags() async throws {
        isLoading = true
        error = nil
        
        do {
            let tags = try await service.getTag().data
            let tagItems = tags.map { TagDisplayItem(from: $0) }
            
            // Группировка тегов по group
            let groupedTags = Dictionary(grouping: tagItems, by: { $0.group })
                .map { (group: $0.key, tags: $0.value) }
                .sorted { $0.group < $1.group }
            
            sections = Array(groupedTags)
        } catch {
            self.error = error
            print("Ошибка при загрузке тегов: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    @MainActor
    func fetchDataTags() async {
        do {
            try await getTags()
        } catch {
            self.error = error
            print(("Ошибка при получении данных: \(error.localizedDescription)"))
        }
    }
    
    func toggleTag(_ tag: TagDisplayItem) {
        if let index = selectedTags.firstIndex(where: { $0.id == tag.id }) {
            selectedTags.remove(at: index)
        } else {
            var newTag = tag
            newTag.isSelected = true
            selectedTags.append(newTag)
        }
        
        // Обновляем состояние
        sections = sections.map { (group, tags) in
            (
                group: group,
                tags: tags.map { item in
                    var updatedItem = item
                    if item.id == tag.id {
                        updatedItem.isSelected = !item.isSelected
                    }
                    return updatedItem
                }
            )
        }
    }
    // Сбрасываем выбранные теги
    func reset() {
        selectedTags.removeAll()
        sections = sections.map { (group, tags) in
            (
                group: group,
                tags: tags.map { item in
                    var updatedItem = item
                    updatedItem.isSelected = false
                    return updatedItem
                }
            )
        }
    }
}
