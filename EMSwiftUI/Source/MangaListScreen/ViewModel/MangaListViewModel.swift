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
    func filteredSections(for searchText: String) -> [MangaSection]
    func getData() async
}

struct MangaSection: Identifiable {
    let id: String
    let title: String
    let mangaList: [MangaData]
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var sections: [MangaSection] = []
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    func filteredSections(for searchText: String) -> [MangaSection] {
        let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            return sections
        }
        
        return sections.compactMap { section in
            let filteredManga = section.mangaList.filter { manga in
                manga.searchableTitle.localizedCaseInsensitiveContains(trimmedQuery)
            }
            
            guard !filteredManga.isEmpty else {
                return nil
            }
            
            return MangaSection(id: section.id, title: section.title, mangaList: filteredManga)
        }
    }
    
    @MainActor func getData() async {
        do {
            async let popular = service.getPopularManga()
            async let recentlyAdded = service.getRecentlyAddedManga()
            async let lastUpdated = service.getLastUpdatedManga()
            async let seasonal = service.getSeasonalManga()

            let popularModel = try await popular
            let recentlyAddedModel = try await recentlyAdded
            let lastUpdatedModel = try await lastUpdated
            let seasonalModel = try await seasonal

            sections = [
                MangaSection(id: "popular", title: "Popular", mangaList: popularModel.data),
                MangaSection(id: "recently-added", title: "Recently Added", mangaList: recentlyAddedModel.data),
                MangaSection(id: "last-updates", title: "Last Updates", mangaList: lastUpdatedModel.data),
                MangaSection(id: "seasonal", title: "Seasonal", mangaList: seasonalModel.data)
            ]
        } catch {
            print("Error fetching manga: \(error)")
        }
    }
}

private extension MangaData {
    var searchableTitle: String {
        if let title = attributes.title.primary, !title.isEmpty {
            return title
        }
        
        return attributes.altTitles
            .compactMap(\.value)
            .first(where: { !$0.isEmpty }) ?? ""
    }
}
