//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Netify
import OSLog

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var items: [MangaListItem] { get }

    var isFetching: Bool { get }
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published private(set) var items: [MangaListItem] = []
    @Published private(set) var isFetching: Bool = false

    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service

        Task {
            await fetchItems()
        }
    }

    @MainActor
    private func fetchItems() async {
        isFetching = true

        do {
            items = try await service.fetchManga().data
                .map(MangaListItem.init)
        } catch {
            Logger.standard.error("\(error)")
        }

        isFetching = false
    }
}
