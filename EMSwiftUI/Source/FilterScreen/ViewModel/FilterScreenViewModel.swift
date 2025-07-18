//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/15/25.
//


import Foundation

protocol FilterScreenViewModel: ObservableObject {
    var tagGroups: [GroupModel] { get }
    var selectedTags: [SingleTagModel] { get }
    func onAppear() async
    func emptySelectedTags()
    func toggleGroup(_ group: GroupModel)
    func toggleTag(_ tag: SingleTagModel)
}

final class FilterScreenViewModelImpl: FilterScreenViewModel {
    @Published var tagGroups: [GroupModel] = []
    @Published var selectedTags: [SingleTagModel] = []

    private var didPerformInitialLoad = false
    private let service: FilterScreenService

    init(service: FilterScreenService) {
        self.service = service
    }

    @MainActor func onAppear() async {
        guard !didPerformInitialLoad else {
            return
        }
        
        do {
            try await getData()
            didPerformInitialLoad = true
        } catch {
            return
        }
    }

    func toggleGroup(_ group: GroupModel) {
        guard let index = tagGroups.firstIndex(where: { $0.id == group.id }) else {
            return
        }
        tagGroups[index].isUnfolded.toggle()
    }

    func toggleTag(_ tag: SingleTagModel) {
        guard let index = selectedTags.firstIndex(where: { tag.id == $0.id }) else {
            selectedTags.append(tag)
            return
        }
        
        selectedTags.remove(at: index)
    }

    func emptySelectedTags() {
        guard !selectedTags.isEmpty else {
            return
        }
        
        selectedTags.removeAll()
    }

    @MainActor private func getData() async throws {
        do {
            let tags = try await service.fetchTags().data
            let tagModels = tags.map {
                SingleTagModel(id: $0.id, title: $0.attributes.name.en ?? "Unknown", group: $0.attributes.group)
            }
            var tagsTable: [String: [SingleTagModel]] = [:]
            
            for tag in tagModels {
                if let _ = tagsTable[tag.group] {
                    tagsTable[tag.group]!.append(tag)
                } else {
                    tagsTable[tag.group] = []
                    tagsTable[tag.group]!.append(tag)
                }
            }
            
            tagGroups = tagsTable.map { key, value in
                GroupModel(title: key, tags: value)
            }
        } catch {
            return
        }
    }
}
