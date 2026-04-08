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
    var sortedKeys: [String] { get }
    
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
    
    var sortedKeys: [String] {
        groupTags.keys.sorted()
    }
    
    init(service: FilterScreenService) {
        self.service = service
    }
    
    func fetchTags() {
        Task {
            do {
                let response = try await service.getTags()
                await MainActor.run {
                    self.groupTags = Dictionary(grouping: response.data, by: {$0.attributes.group})
                }
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
    
    static func formatTitle(_ key: String) -> String {
        switch key.lowercased() {
        case "content":
            return "Content Rating"
        case "format":
            return "Format"
        case "genre":
            return "Genre"
        case "theme":
            return "Theme"
        case "magazine":
            return "Magazine Demographic"
        default: return key.capitalized
        }
    }
}
