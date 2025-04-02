//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 30.03.2025.
//

import Foundation
import OSLog
import SwiftUI
import Factory
import Netify

protocol FilterScreenViewModelProtocol: ObservableObject {
    var items: [FilterItem] { get }
    var selectedItems: [FilterItem] { get }

    @MainActor
    func fetchItems() async

    @MainActor
    func getItems(for category: FilterCategory) -> [FilterItem]

    @MainActor
    func selectItem(_ item: FilterItem)

    @MainActor
    func applySelction()

    @MainActor
    func resetSelection()
}

final class FilterScreenViewModel: FilterScreenViewModelProtocol {
    @Published var items: [FilterItem] = []
    var selectedItems: [FilterItem] {
        items.filter { $0.isSelected }
    }

    let service: FilterService

    init(service: FilterService) {
        self.service = service
    }

    @MainActor
    func fetchItems() async {
        do {
            items = try await service.fetchMangaTags().data
                .map(FilterItem.init)
        } catch {
            Logger.standard.error("\(error)")
        }
    }

    @MainActor
    func getItems(for category: FilterCategory) -> [FilterItem] {
        switch category {
        case .other:
            let other = FilterCategory.allCases.filter { $0 != .other }

            return items.filter { !other.contains($0.category) }
        default:
            return items.filter { $0.category == category }
        }
    }

    @MainActor
    func selectItem(_ item: FilterItem) {
        guard let index = items.firstIndex(where: {$0 == item }) else { return }

        items[index].isSelected.toggle()
    }

    @MainActor
    func applySelction() {
        Logger.standard.debug("\(self.selectedItems.map { $0.category.title })")
    }

    @MainActor
    func resetSelection() {
        items = items.map { immutableItem in
            var item = immutableItem
            item.isSelected = false
            return item
        }
    }
}
