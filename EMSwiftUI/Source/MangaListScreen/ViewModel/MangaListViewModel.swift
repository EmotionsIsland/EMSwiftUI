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
    var popularMangas: [MangaModel] { get }
    var recentlyAddedMangas: [MangaModel] { get }
    var lastUpdatedMangas: [MangaModel] { get }
    var viewState: ViewState { get }
    func loadData() async
    func retry() async
}

final class MangaListViewModelImpl: MangaListViewModel {
    private let service: MangaListService

    @Published var popularMangas: [MangaModel] = []
    @Published var recentlyAddedMangas: [MangaModel] = []
    @Published var lastUpdatedMangas: [MangaModel] = []
    @Published var viewState: ViewState = .initial

    init(service: MangaListService) {
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

    @MainActor private func getData() async {
        do {
            async let popularMangas = service.getMangaModels(withOrder: .popular)
            async let recentlyAddedMangas = service.getMangaModels(withOrder: .recentlyAdded)
            async let lastUpdatedMangas = service.getMangaModels(withOrder: .lastUpdates)
            (self.popularMangas, self.recentlyAddedMangas, self.lastUpdatedMangas) = try await (popularMangas, recentlyAddedMangas, lastUpdatedMangas)
            viewState = .loaded
        } catch let error {
            viewState = .error(error as? NetworkError ?? .unknown(statusCode: -1))
        }
    }
}
