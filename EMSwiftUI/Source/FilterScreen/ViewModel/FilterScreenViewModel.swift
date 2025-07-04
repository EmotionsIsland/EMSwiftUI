//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Ruslan on 25.06.2025.
//

import Combine
import Foundation

protocol FilterScreenViewModel: ObservableObject {
    var tags: [MangaTagRepresentable] { get set }
    
    var selectedTags: [MangaTagRepresentable] { get set }
    
    func didTapOnTag(tagId: String, isSelected: Bool)
    
    func filterForSection(group: TagGroup) -> [MangaTagRepresentable]
    
    func reset()
}

final class FilterScreenViewModelIml: FilterScreenViewModel {
    private let service: TagService
    
    @Published var tags: [MangaTagRepresentable] = []
    
    @Published var selectedTags: [MangaTagRepresentable] = []
    
    init(service: TagService) {
        self.service = service
        Task {
            try? await loadTags()
        }
    }
    
    @MainActor private func loadTags() async throws {
        Task {
            do {
                let data = try await service.loadTags().data
                tags = data.map( { self.mapToRepresentable(tag: $0)})
            } catch {
                throw(error)
            }
        }
    }
    
    func didTapOnTag(tagId: String, isSelected: Bool) {
        guard let index = tags.firstIndex(where: { $0.id == tagId }) else {
            return
        }
            tags[index].isSelected.toggle()
        
        if isSelected {
            selectedTags.removeAll(where: { $0.id == tagId })
        } else {
            if let tag = tags.first(where: { $0.id == tagId}) {
                selectedTags.append(tag)
            }
        }
    }
    
    func reset() {
        selectedTags.forEach({ selectedTag in
            if let index = tags.firstIndex(where: { $0.id == selectedTag.id }) {
                tags[index].isSelected = false
            }
        })
        selectedTags.removeAll()
    }
    
    func filterForSection(group: TagGroup) -> [MangaTagRepresentable] {
        tags.filter( { $0.group == group })
    }
    
    private func mapToRepresentable(tag: Datum) -> MangaTagRepresentable {
        let name = tag.attributes.name.en
        
        let group = tag.attributes.group
        
        let id = tag.id
        
        return .init(
            id: id,
            name: name,
            group: group)
    }
}
