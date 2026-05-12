//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 29.04.2026.
//

import Foundation

enum FilterViewState: Equatable {
    case loading
    case content
    case error(String)
}

protocol FilterViewModel: ObservableObject {
    var viewState: FilterViewState { get }
    var groupedTags: [String: [FilterTagItem]] { get }
    var selectedTags: Set<FilterTagItem> { get }
    var sortedGroupTitles: [String] { get }
    var selectedTagsOrdered: [FilterTagItem] { get }
    var expandedGroups: Set<String> { get }
    var isLoading: Bool { get }

    func onAppear()
    func tags(inGroup group: String) -> [FilterTagItem]
    func toggleGroup(_ group: String)
    func toggleTag(_ tag: FilterTagItem)
    func retry()
    func reset()
}

final class FilterViewModelImpl: FilterViewModel {
    @Published private(set) var viewState: FilterViewState = .loading
    @Published private(set) var groupedTags: [String: [FilterTagItem]] = [:]
    @Published var selectedTags: Set<FilterTagItem> = []
    @Published private(set) var expandedGroups: Set<String> = []
    @Published private(set) var isLoading = false

    private let service: FilterService
    private var didLoad = false

    var sortedGroupTitles: [String] {
        groupedTags.keys.sorted()
    }
    
    var selectedTagsOrdered: [FilterTagItem] {
        selectedTags.sorted {
            $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
        }
    }

    init(service: FilterService) {
        self.service = service
    }

    func onAppear() {
        guard !didLoad else { return }
        didLoad = true
        Task {
            await loadTags()
        }
    }

    func retry() {
            Task { await loadTags() }
        }

    func tags(inGroup group: String) -> [FilterTagItem] {
        groupedTags[group] ?? []
    }

    func toggleGroup(_ group: String) {
        if expandedGroups.contains(group) {
            expandedGroups.remove(group)
        } else {
            expandedGroups.insert(group)
        }
    }

    func toggleTag(_ tag: FilterTagItem) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }

    func reset() {
        selectedTags.removeAll()
    }
}

private extension FilterViewModelImpl {
    func loadTags() async {
        await MainActor.run {
            viewState = .loading
        }
        do {
            let response = try await service.getTags()
            let data = response.data
            let grouped = await Task.detached(priority: .userInitiated) {
                Self.makeGroupedTags(from: data)
            }.value
            await MainActor.run {
                groupedTags = grouped
                viewState = .content
            }
        } catch {
            await MainActor.run {
                groupedTags = [:]
                viewState = .error(error.localizedDescription)
            }
        }
    }

    static func makeGroupedTags(from tags: [Tag]) -> [String: [FilterTagItem]] {
        let items = tags.compactMap { tag -> FilterTagItem? in
            guard let title = tag.attributes.name.en else {
                return nil
            }
            return FilterTagItem(
                id: tag.id,
                title: title,
                group: tag.attributes.group
            )
        }
        return Dictionary(grouping: items, by: \.group)
            .mapValues { $0.sorted { $0.title < $1.title } }
    }
}
