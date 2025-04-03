//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Netify

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var mangaList: [MangaData] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var mangaTitle: [String] { get }
    var searchText: String { get set }
    var filteredMangaList: [MangaData] { get }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL?
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published private(set) var mangaList: [MangaData] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var filteredMangaList: [MangaData] = []
    @Published var searchText: String = "" {
        didSet {
            filterMangaList()
        }
    }
    
    var mangaTitle = ["Popular", "Recently Added", "Last Updates", "Seasonal"]
    
    private let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
        loadInitialData()
    }
    
    @MainActor func getData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let data = try await service.getManga()
            self.mangaList = data.data
            self.filteredMangaList = data.data
        } catch {
            self.errorMessage = "Ошибка загрузки: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat = .size256) -> URL? {
        API.coverURL(for: manga, sizeFormat)
    }
    
    private func filterMangaList() {
        if searchText.isEmpty {
            filteredMangaList = mangaList
        } else {
            filteredMangaList = mangaList.filter { manga in
                manga.attributes.title.en?.lowercased()
                    .contains(searchText.lowercased()) ?? false
            }
        }
    }
    
    private func loadInitialData() {
        Task {
            await getData()
        }
    }
}
