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
    let mangaList: [MangaListItem]
}

struct MangaListItem: Identifiable {
    let manga: MangaData
    
    var id: String {
        manga.id
    }
    
    var titleText: String {
        searchableTitle.isEmpty ? "No title" : searchableTitle
    }
    
    var tagsText: String {
        let tags = manga.attributes.tags
            .compactMap(\.attributes.name.english)
            .filter { !$0.isEmpty }
        
        guard !tags.isEmpty else {
            return "No tags"
        }
        
        return tags.prefix(3).joined(separator: ", ")
    }
    
    var searchableTitle: String {
        if let title = manga.attributes.title.primary, !title.isEmpty {
            return title
        }
        
        return manga.attributes.altTitles
            .compactMap(\.value)
            .first(where: { !$0.isEmpty }) ?? ""
    }
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
            let filteredManga = section.mangaList.filter { item in
                item.searchableTitle.localizedCaseInsensitiveContains(trimmedQuery)
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
                MangaSection(id: "popular", title: "Popular", mangaList: popularModel.data.map(MangaListItem.init)),
                MangaSection(
                    id: "recently-added",
                    title: "Recently Added",
                    mangaList: recentlyAddedModel.data.map(MangaListItem.init)
                ),
                MangaSection(id: "last-updates", title: "Last Updates", mangaList: lastUpdatedModel.data.map(MangaListItem.init)),
                MangaSection(id: "seasonal", title: "Seasonal", mangaList: seasonalModel.data.map(MangaListItem.init))
            ]
        } catch {
            print("Error fetching manga: \(error)")
        }
    }
}
