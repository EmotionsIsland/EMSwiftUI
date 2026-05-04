//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 29.04.2026.
//

import Foundation

protocol FilterViewModel: ObservableObject {
    var groupedTags: [String: [FilterTagItem]] { get }
    var selectedTags: Set<FilterTagItem> { get }
    var expandedGroups: Set<String> { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }

    func onAppear()
    func toggleGroup(_ group: String)
    func toggleTag(_ tag: FilterTagItem)
    func reset()
    func apply()
}

@MainActor
final class FilterViewModelImpl: FilterViewModel {
    @Published private(set) var groupedTags: [String: [FilterTagItem]] = [:]
    @Published var selectedTags: Set<FilterTagItem> = []
    @Published private(set) var expandedGroups: Set<String> = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service: FilterService
    private var didLoad = false

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

    func apply() {
        // Здесь позже можно прокинуть selectedTags в MangaListScreen
        // или собрать query-параметры для API.
    }
}

// MARK: - Private

private extension FilterViewModelImpl {
    func loadTags() async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await service.getTags()
            groupedTags = makeGroupedTags(from: response.data)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func makeGroupedTags(from tags: [Tag]) -> [String: [FilterTagItem]] {
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
