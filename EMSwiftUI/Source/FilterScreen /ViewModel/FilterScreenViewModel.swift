//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Анатолий Чириков on 24.03.2026.
//

import Foundation
import Netify

protocol FilterScreenViewModel: ObservableObject {
    var groupTags: [String: [Tag]] { get }
    var selectedTagsIDs: Set<String> { get }
    var selectedTags: [Tag] { get  }
    
    func fetchTags()
    func toggleTag(id: String)
    func reset()
}

final class FilterScreenViewModelImpl: FilterScreenViewModel {
    private let service: FilterScreenService
    
    @Published var groupTags: [String: [Tag]] = [:]
    @Published var selectedTagsIDs: Set<String> = []
    var selectedTags: [Tag] {
        let allTags = groupTags.values.flatMap {$0 }
        return allTags.filter {selectedTagsIDs.contains($0.id) }
    }
    
    init(service: FilterScreenService) {
        self.service = service
    }
    
    @MainActor private func getTags() async throws {
        let response = try await service.getTags()
        let allTags = response.data
        
        self.groupTags = Dictionary(grouping: allTags, by: {tag in
            tag.attributes.group
        })
    }
    
    func fetchTags() {
        Task {
            do {
                try await getTags()
            } catch {
                print("Ошибка загузки тэгов:\(error.localizedDescription)")
            }
        }
    }
    
    func toggleTag(id: String) {
        if selectedTagsIDs.contains(id) {
            selectedTagsIDs.remove(id)
        } else {
            selectedTagsIDs.insert(id)
        }
    }
    
    func reset() {
        selectedTagsIDs.removeAll()
    }
}
