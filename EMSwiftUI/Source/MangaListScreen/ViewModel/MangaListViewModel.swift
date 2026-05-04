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
    var sections: [MangaSection] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }

    func onAppear()
}

@MainActor
final class MangaListViewModelImpl: MangaListViewModel {
    @Published private(set) var sections: [MangaSection] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let service: MangaListService
    private let placeholderRating: CGFloat = 4.2

    init(service: MangaListService) {
        self.service = service
    }

    func onAppear() {
        Task {
            await getData()
        }
    }

    private func getData() async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await service.getManga()

            // пока просто заглушка
            sections = makeSections(from: response.data)

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func makeSections(from data: [MangaData]) -> [MangaSection] {
        let items = data.compactMap { mapItem(from: $0) }

        return [
            MangaSection(title: "Popular", items: items),
            MangaSection(title: "Recently Added", items: items),
            MangaSection(title: "Last Updates", items: items)
        ]
    }

    private func mapItem(from data: MangaData) -> MangaItem? {
        guard let title = data.attributes.title.displayTitle else {
            return nil
        }

        let genres = data.attributes.tags
            .compactMap { $0.attributes.name.displayTitle ?? $0.attributes.name.en }
            .joined(separator: ", ")

        let coverFileName = data.relationships
            .first(where: { $0.type == "cover_art" })?
            .attributes?.fileName

        let coverURL = makeCoverURL(
            mangaId: data.id,
            fileName: coverFileName
        )

        return MangaItem(
            id: data.id,
            title: title,
            genres: genres,
            coverURL: coverURL,
            rating: placeholderRating
        )
    }

    private func makeCoverURL(mangaId: String, fileName: String?) -> URL? {
        guard let fileName else { return nil }

        return URL(
            string: "https://uploads.mangadex.org/covers/\(mangaId)/\(fileName)"
        )
    }
}
