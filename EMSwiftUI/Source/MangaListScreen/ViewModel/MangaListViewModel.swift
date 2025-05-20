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
    var mangaList: MangaListModel? { get }
    var isLoading: Bool { get }
    func getData() async throws
    func getCoverURL(for manga: MangaData) -> URL?
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var mangaList: MangaListModel?
    @Published var isLoading: Bool = false
    private let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor func getData() async throws {
        isLoading = true
        mangaList = try await service.getManga()
        isLoading = false
    }
    
    func getCoverURL(for manga: MangaData) -> URL? {
        API.coverURL(for: manga, .size512)
    }
}
