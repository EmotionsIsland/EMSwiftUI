//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by mm pechenbku on 03.06.2025.
//

import SwiftUI

protocol FilterScreenViewModelProtocol: ObservableObject {
    var filterGroups: [FilterGroupViewModel] { get }
    var selectedFilters: [String] { get }
    var openedGroups: [String] { get }

    func filterSelected(with name: String)
    func groupSelected(with name: String)
    func applyFilters()
    func resetFilters()
}

struct FilterGroupViewModel: Hashable {
    let title: String
    let filters: [String]
}

final class FilterScreenViewModel: FilterScreenViewModelProtocol {
    // MARK: Internal Properties

    @Published private(set) var filterGroups: [FilterGroupViewModel] = []
    @Published private(set) var selectedFilters: [String] = []
    @Published private(set) var openedGroups: [String] = []

    // MARK: - Private Properties

    private let service: FilterScreenServiceProtocol
    private var filters: [Tag] = [] {
        didSet {
            self.filterGroups = []
            var filterGroupsDict: [String: [String]] = [:]
            self.filters.forEach { tag in
                if let name = tag.attributes.name.en {
                    filterGroupsDict[tag.attributes.group.localizedCapitalized, default: []].append(name)
                }
            }
            filterGroupsDict.forEach { (title, filters) in
                filterGroups.append(.init(title: title, filters: filters))
            }
        }
    }

    // MARK: - Init

    init(service: FilterScreenServiceProtocol) {
        self.service = service
        Task { try await self.getData() }
    }

    // MARK: - Internal Methods

    func filterSelected(with name: String) {
        self.valueSelected(in: &selectedFilters, value: name)
    }

    func groupSelected(with name: String) {
        self.valueSelected(in: &openedGroups, value: name)
    }

    func applyFilters() {}

    func resetFilters() {
        self.selectedFilters = []
    }
}

private extension FilterScreenViewModel {
    @MainActor
    func getData() async throws {
        guard let response = try? await service.getFilters() else { return }
        self.filters = response.data
    }

    func setupFitlerGroups(with filters: [Tag]) {
        var filterGroups: [FilterGroupViewModel] = []
        var filterGroupsDict: [String: [String]] = [:]
        self.filters.forEach { tag in
            if let name = tag.attributes.name.en {
                filterGroupsDict[tag.attributes.group.localizedCapitalized, default: []].append(name)
            }
        }
        filterGroupsDict.forEach { (title, filters) in
            filterGroups.append(.init(title: title, filters: filters))
        }
        self.filterGroups = filterGroups
    }

    func valueSelected<Value: Hashable>(in data: inout [Value]/*<Value>*/, value: Value) {
        if data.contains(value) {
            data.removeAll { $0 == value }
        } else {
            data.append(value)
        }
    }
}
