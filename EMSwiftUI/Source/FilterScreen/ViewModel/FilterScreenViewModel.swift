//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import Foundation
import SwiftUI

protocol FilterScreenViewModel: ObservableObject {
    var loadingState: LoadState<[String: [FilterChipItem]]> { get }
    var groupedTags: [String: [FilterChipItem]] { get }
    var selectedItems: Set<FilterChipItem> { get }
    var expandedGroupIDs: Set<String> { get }

    func load()
    func retry()
    func toggleGroup(_ group: String)
    func toggleSelection(for item: FilterChipItem)
    func resetSelection()
    func applyAndDismiss(using dismiss: DismissAction)
}

final class FilterScreenViewModelImpl: FilterScreenViewModel {
    @Published private(set) var loadingState: LoadState<[String: [FilterChipItem]]> = .loading
    @Published private(set) var groupedTags: [String: [FilterChipItem]] = [:]
    @Published var selectedItems: Set<FilterChipItem> = []
    @Published private(set) var expandedGroupIDs: Set<String> = []

    private let tagService: TagService
    private let mapper: TagGroupMapper
    private var loadTask: Task<Void, Never>?

    init(tagService: TagService, mapper: TagGroupMapper) {
        self.tagService = tagService
        self.mapper = mapper
    }

    func load() {
        guard loadTask == nil else { return }
        loadingState = .loading
        loadTask = Task {
            do {
                let tags = try await tagService.fetchTags()
                let grouped = mapper.groupTags(tags)
                await MainActor.run {
                    self.groupedTags = grouped
                    self.loadingState = .loaded(grouped)
                    self.loadTask = nil
                }
            } catch {
                await MainActor.run {
                    self.loadingState = .error(error.localizedDescription)
                    self.loadTask = nil
                }
            }
        }
    }

    func retry() {
        load()
    }

    func toggleGroup(_ group: String) {
        if expandedGroupIDs.contains(group) {
            expandedGroupIDs.remove(group)
        } else {
            expandedGroupIDs.insert(group)
        }
    }

    func toggleSelection(for item: FilterChipItem) {
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }

    func resetSelection() {
        selectedItems.removeAll()
    }

    func applyAndDismiss(using dismiss: DismissAction) {
        dismiss()
    }
}
