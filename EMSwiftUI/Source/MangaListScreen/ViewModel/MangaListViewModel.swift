//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Netify

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var screenState: MangaListViewState { get }
    var sections: [MangaSection] { get }

    func loadIfNeeded() async
    func reload() async
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published private(set) var screenState: MangaListViewState = .isLoading
    @Published private(set) var sections: [MangaSection] = []

    private let service: MangaListService
    private var hasLoaded = false

    init(service: MangaListService) {
        self.service = service
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        await reload()
    }
    
    func reload() async {
        await setLoading()
        
        do {
            let loadedSections = try await loadAllSections()
            await applyLoadedSections(loadedSections)
            hasLoaded = true
        } catch {
            await setFailed(error.localizedDescription)
        }
    }
}

private extension MangaListViewModelImpl {
    func loadAllSections() async throws -> [MangaSection] {
        let configs: [MangaSectionConfig] = [
            MangaSectionConfig(
                id: "popular",
                title: "Popular",
                sort: .popular
            ),
            MangaSectionConfig(
                id: "recent",
                title: "Recently Added",
                sort: .recentlyAdded
            ),
            MangaSectionConfig(
                id: "updates",
                title: "Last Updates",
                sort: .lastUpdates
            )
        ]

        return try await withThrowingTaskGroup(
            of: (Int, MangaSection).self
        ) { group in
            for (index, config) in configs.enumerated() {
                group.addTask { [service] in
                    let response = try await service.getManga(sort: config.sort)
                    let items = response.data.map { MangaGridItemViewModel(manga: $0) }

                    let section = MangaSection(
                        id: config.id,
                        title: config.title,
                        items: items
                    )

                    return (index, section)
                }
            }

            var tempSections: [(Int, MangaSection)] = []

            for try await result in group {
                tempSections.append(result)
            }

            return tempSections
                .sorted { $0.0 < $1.0 }
                .map(\.1)
        }
    }

    @MainActor
    func setLoading() {
        screenState = .isLoading
    }

    @MainActor
    func applyLoadedSections(_ loadedSections: [MangaSection]) {
        sections = loadedSections
        screenState = .isLoaded
    }

    @MainActor
    func setFailed(_ message: String) {
        screenState = .failed(error: message)
    }
}
