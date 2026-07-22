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
    func loadData() async
}

final class MangaListViewModelImpl: MangaListViewModel {
    private let service: MangaListService

    @Published var popularMangas: [MangaModel] = []
    @Published var recentlyAddedMangas: [MangaModel] = []
    @Published var lastUpdatedMangas: [MangaModel] = []

    init(service: MangaListService) {
        self.service = service
    }

    func loadData() async {
        try? await getData()
    }

    @MainActor private func getData() async throws {
        popularMangas = try await convertToMangaModel(service.getManga(withOrder: .popular).data)
        recentlyAddedMangas = try await convertToMangaModel(service.getManga(withOrder: .recentlyAdded).data)
        lastUpdatedMangas = try await convertToMangaModel(service.getManga(withOrder: .lastUpdates).data)
    }

    private func convertToMangaModel(_ mangas: [MangaData]) -> [MangaModel] {
        mangas.compactMap { mangaData in
            let title = mangaData.attributes.title
            let altTitles = mangaData.attributes.altTitles
            return MangaModel(
                id: mangaData.id,
                coverUrl: API.coverURL(for: mangaData),
                title: title.en
                    ?? altTitles.compactMap { $0.en }.first
                    ?? title.ru
                    ?? altTitles.compactMap { $0.ru }.first
                    ?? title.jaRo
                    ?? altTitles.compactMap { $0.jaRo }.first
                    ?? "Missing title",
                genres: mangaData.attributes.tags
                    .filter { $0.attributes.group == "genre" }
                    .compactMap { $0.attributes.name.en }
                )
        }
    }
}
