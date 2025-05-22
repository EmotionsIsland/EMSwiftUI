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
    var mangaListPopular: [MangaData] { get }
    var mangaListRecentlyAdded: [MangaData] { get }
    var mangaListLastUpdates: [MangaData] { get }
    var mangaListSeasonal: [MangaData] { get }
    var isLoading: Bool { get }
    func getData() async throws
    func getCoverURL(for manga: MangaData) -> URL?
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published private(set) var mangaListPopular: [MangaData] = []
    @Published private(set) var mangaListRecentlyAdded: [MangaData] = []
    @Published private(set) var mangaListLastUpdates: [MangaData] = []
    @Published private(set) var mangaListSeasonal: [MangaData] = []
    @Published var isLoading: Bool = false
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    func getData() async throws {
        let fetched = try await service.getManga().data
        await MainActor.run {
            isLoading = true
            mangaListPopular = fetched.sorted { $0.attributes.version > $1.attributes.version }
            mangaListRecentlyAdded = fetched.sorted { $0.attributes.createdAt > $1.attributes.createdAt }
            mangaListLastUpdates = fetched.sorted { $0.attributes.updatedAt > $1.attributes.updatedAt }
            mangaListSeasonal = fetched.sorted { $0.attributes.version > $1.attributes.version }
            isLoading = false
        }
    }
    
    func getCoverURL(for manga: MangaData) -> URL? {
        API.coverURL(for: manga, .size512)
    }
}
