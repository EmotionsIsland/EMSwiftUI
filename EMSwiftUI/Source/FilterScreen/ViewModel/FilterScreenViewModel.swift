//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Глеб Поляков on 06.07.2025.
//

import Foundation

protocol FilterScreenViewModel: ObservableObject {
    var tagGroups: [TagGroup] { get }
    var chosenTags: [TagPresentationModel] { get }
    var loadState: LoadState { get }
    func onAppear() async throws
    func resetTags()
    func toggleGroup(_ group: TagGroup)
    func toggleTag(_ tag: TagPresentationModel)
}

final class FilterScreenViewModelImpl: FilterScreenViewModel {
    @Published var tagGroups: [TagGroup] = []
    @Published var chosenTags: [TagPresentationModel] = []
    @Published var loadState: LoadState = .idle
    
    private let service: FilterScreenService
    
    init(service: FilterScreenService) {
        self.service = service
    }
    
    @MainActor func onAppear() async throws {
        loadState = .loading
        do {
            try await getData()
            loadState = .success
        } catch {
            loadState = .failure(error)
        }
    }
    
    func toggleGroup(_ group: TagGroup) {
        guard let index = tagGroups.firstIndex(where: { $0.id == group.id }) else {
            return
        }
        tagGroups[index].isExpanded.toggle()
    }
    
    func toggleTag(_ tag: TagPresentationModel) {
        if let index = chosenTags.firstIndex(of: tag) {
            chosenTags.remove(at: index)
        } else {
            chosenTags.append(tag)
        }
    }
    
    func resetTags() {
        guard !chosenTags.isEmpty else {
            return
        }
        chosenTags.removeAll()
    }
    
    // MARK: - Private methods
    @MainActor private func getData() async throws {
        do {
            let tagsModels = try await service.getTags()
            let presentationModels = tagsModels.data.map {
                TagPresentationModel(id: $0.id, title: $0.attributes.name.en ?? "", group: $0.attributes.group)
            }
            
            let grouped = Dictionary(grouping: presentationModels, by: { $0.group })
            tagGroups = grouped.map { key, value in
                TagGroup(groupTitle: key, tags: value)
            }
        } catch {
            print("Failed to decode data: \(error.localizedDescription)")
        }
    }
}
