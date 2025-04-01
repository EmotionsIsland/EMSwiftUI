//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import UIKit
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
    var filteredMangaList: [MangaData] { get set }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL?
    func getData() async throws
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var mangaList: [MangaData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var filteredMangaList: [MangaData] = [] // Фильтрованный список
    @Published var searchText: String = "" {
        didSet {
            filterMangaList()
        }
    }
    
    var getRandomRating: CGFloat {
        CGFloat.random(in: 1...5)
    }
    
    var mangaTitle = ["Popular", "Recently Added", "Last Updates", "Seasonal"]
    
    private let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
    }
    
    func fillRatio(for index: Int, rating: CGFloat) -> CGFloat {
        let remainingRating = rating - CGFloat(index)
        return min(max(remainingRating, 0), 1)
    }
    
    @MainActor func getData() async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let data = try await service.getManga()
            self.mangaList = data.data
            self.filteredMangaList = data.data
            print(data)
        } catch {
            self.errorMessage = "Ошибка загрузки: \(error.localizedDescription)"
            throw error
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
                    manga.attributes.title.en?.lowercased().contains(searchText.lowercased()) ?? false
                }
            }
        }
}
