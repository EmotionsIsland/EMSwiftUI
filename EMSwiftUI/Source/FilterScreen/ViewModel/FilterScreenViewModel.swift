//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 23.07.2026.
//

import Foundation
import Netify

protocol FilterViewModel: ObservableObject {
    var viewState: ViewState { get }
    var allTags: [Tag] { get }
    var selectedTags: [Tag] { get }
    var groupedTags: [(key: String, tags: [Tag])] { get }
    func loadData() async
    func retry() async
    func isSelected(_ tag: Tag) -> Bool
    func toggleSelection(for tag: Tag)
    func resetSelection()
    func displayName(for groupKey: String) -> String
}

final class FilterViewModelImpl: FilterViewModel {
    private let service: FilterService

    @Published var selectedTags: [Tag] = []
    @Published var allTags: [Tag] = []
    @Published var viewState: ViewState = .initial

    var groupedTags: [(key: String, tags: [Tag])] {
        let grouped = Dictionary(grouping: allTags) { $0.attributes.group }
        return grouped
            .map { (key: $0.key, tags: $0.value) }
            .sorted { $0.key < $1.key }
    }

    init(service: FilterService) {
        self.service = service
    }

    @MainActor func loadData() async {
        guard case .initial = viewState else { return }
        viewState = .loading
        await getData()
    }

    @MainActor func retry() async {
        if case .loading = viewState { return }
        viewState = .loading
        await getData()
    }

    func isSelected(_ tag: Tag) -> Bool {
        selectedTags.contains(where: { $0.id == tag.id })
    }

    func displayName(for groupKey: String) -> String {
        groupKey.lowercased() == "content"
            ? "Content Rating"
            : groupKey.capitalized
    }

    func toggleSelection(for tag: Tag) {
        if let index = selectedTags.firstIndex(where: { $0.id == tag.id }) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
    }

    func resetSelection() {
        selectedTags.removeAll()
    }

    @MainActor private func getData() async {
        do {
            allTags = try await service.getTags().data
            viewState = .loaded
        } catch let error {
            viewState = .error(error as? NetworkError ?? .unknown(statusCode: -1))
        }
    }
}
