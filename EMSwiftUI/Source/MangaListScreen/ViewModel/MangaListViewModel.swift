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

enum MangaSection: Identifiable {
    case popular(models: [MangaViewModel])
    case recentlyAdded(models: [MangaViewModel])
    case lastUpdates(models: [MangaViewModel])
    case seasonal(models: [MangaViewModel])

    var models: [MangaViewModel] {
        switch self {
        case .popular(models: let models):
            return models
        case .recentlyAdded(models: let models):
            return models
        case .lastUpdates(models: let models):
            return models
        case .seasonal(models: let models):
            return models
        }
    }

    var title: String {
        switch self {
        case .popular: "Popular"
        case .recentlyAdded: "Recently added"
        case .lastUpdates: "Last updates"
        case .seasonal: "Seasonal"
        }
    }

    var id: Int {
        switch self {
        case .popular:
            return 0
        case .recentlyAdded:
            return 1
        case .lastUpdates:
            return 2
        case .seasonal:
            return 3
        }
    }
}

struct MangaViewModel: Identifiable {
    let id: String
    let title: String
    let coverUrl: URL?
    let tags: String
    let rating: CGFloat
}

protocol MangaListViewModel: ObservableObject {
    var modelState: ModelState<[MangaSection]> { get }
}

final class MangaListViewModelImpl: MangaListViewModel {
    // MARK: - Internal Properties

    @Published private(set) var modelState: ModelState<[MangaSection]> = .loading

    // MARK: - Private Properties

    private var mangaModels: [MangaData] = [] {
        didSet {
            sortIntoSections(models: mangaModels)
        }
    }
    private let service: MangaListService

    // MARK: - Init

    init(service: MangaListService) {
        self.service = service
        Task { try? await self.getData() }
    }
}

private extension MangaListViewModelImpl {
    @MainActor
    func getData() async throws {
        modelState = .loading
        guard let response = try? await service.getManga() else {
            modelState = .error
            return
        }
        self.mangaModels = response.data
    }

    func sortIntoSections(models: [MangaData]) {
        let models: [MangaSection] = [
            .popular(
                models: models.map {
                    .init(
                        id: $0.id,
                        title: $0.attributes.title.en ?? $0.attributes.altTitles.first?.ru ?? "No title",
                        coverUrl: self.service.getCover(for: $0, sizeFormat: .size512),
                        tags: $0.attributes.tags.map { $0.attributes.name.en ?? "" }.joined(separator: ","),
                        rating: CGFloat.random(in: 3...5)
                    )
                }.sorted { $0.rating > $1.rating }
            ),
            .recentlyAdded(
                models: models
                    .sorted { $0.attributes.createdAt > $1.attributes.createdAt }
                    .map {
                        .init(
                            id: $0.id,
                            title: $0.attributes.title.en ?? $0.attributes.altTitles.first?.ru ?? "No title",
                            coverUrl: self.service.getCover(for: $0, sizeFormat: .size512),
                            tags: $0.attributes.tags.map { $0.attributes.name.en ?? "" }.joined(separator: ","),
                            rating: CGFloat.random(in: 3...5)
                        )
                    }
            ),
            .lastUpdates(
                models: models
                    .sorted { $0.attributes.updatedAt > $1.attributes.updatedAt }
                    .map {
                        .init(
                            id: $0.id,
                            title: $0.attributes.title.en ?? $0.attributes.altTitles.first?.ru ?? "No title",
                            coverUrl: self.service.getCover(for: $0, sizeFormat: .size512),
                            tags: $0.attributes.tags.map { $0.attributes.name.en ?? "" }.joined(separator: ","),
                            rating: CGFloat.random(in: 3...5)
                        )
                }
            ),
            .seasonal(
                models: models
                    .filter { isDateIsCurrentSeason(dateString: $0.attributes.createdAt) }
                    .map {
                        .init(
                            id: $0.id,
                            title: $0.attributes.title.en ?? $0.attributes.altTitles.first?.ru ?? "No title",
                            coverUrl: self.service.getCover(for: $0, sizeFormat: .size512),
                            tags: $0.attributes.tags.map { $0.attributes.name.en ?? "" }.joined(separator: ","),
                            rating: CGFloat.random(in: 3...5)
                        )
                    }
            )
        ]

        self.modelState = .loaded(models)
    }

    func isDateIsCurrentSeason(dateString: String) -> Bool {
        let isoFormatter = ISO8601DateFormatter()

        guard let inputDate = isoFormatter.date(from: dateString) else { return false }

        let calendar = Calendar.current
        let currentDate = Date()

        let inputYear = calendar.component(.year, from: inputDate)
        let currentYear = calendar.component(.year, from: currentDate)

        guard inputYear == currentYear else {
            return false
        }

        func season(for date: Date) -> Int {
            let month = calendar.component(.month, from: date)
            switch month {
            case 3...5: return 1
            case 6...8: return 2
            case 9...11: return 3
            default: return 4
            }
        }

        return season(for: inputDate) == season(for: currentDate)
    }
}

extension MangaViewModel {
    static func makeMockModels() -> [MangaViewModel] {
        return [
            .init(id: UUID().uuidString, title: "Manga", coverUrl: nil, tags: "Tag tagtag tagtagtag", rating: 5),
            .init(id: UUID().uuidString, title: "Manga", coverUrl: nil, tags: "Tag tagtag tagtagtag", rating: 5),
            .init(id: UUID().uuidString, title: "Manga", coverUrl: nil, tags: "Tag tagtag tagtagtag", rating: 5),
            .init(id: UUID().uuidString, title: "Manga", coverUrl: nil, tags: "Tag tagtag tagtagtag", rating: 5),
            .init(id: UUID().uuidString, title: "Manga", coverUrl: nil, tags: "Tag tagtag tagtagtag", rating: 5),
            .init(id: UUID().uuidString, title: "Manga", coverUrl: nil, tags: "Tag tagtag tagtagtag", rating: 5)
        ]
    }
}
