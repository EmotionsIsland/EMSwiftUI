//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Netify
import Combine

protocol MangaListViewModel: ObservableObject {
    var dataState: DataState { get }
    var filteredData: [MangaData] { get }
    var searchText: String { get set }
    var headers: [String] { get }
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL?
}

final class MangaListViewModelImpl: MangaListViewModel {
    private let service: MangaListService
    private var mangaData: [MangaData] = []

    let headers = ["Popular", "Recently Added"]

    @Published var searchText: String = "" {
        didSet {
            filterMangaData(by: searchText)
        }
    }
    @Published var dataState: DataState = .notAvailable
    @Published var filteredData: [MangaData] = []

    init(service: MangaListService) {
        self.service = service
        Task {
            await getData()
        }
    }

    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL? {
        return service.getCoverURL(manga: manga, sizeFormat: sizeFormat)
    }
}

private extension MangaListViewModelImpl {
    @MainActor func getData() async {
        do {
            let result = try await service.getManga()
            mangaData = result.data
            dataState = .successfull
        } catch {
            dataState = .failed(error: error)
        }
    }

    func filterMangaData(by text: String) {
        guard !text.isEmpty else {
            filteredData = mangaData
            return
        }
        filteredData = mangaData.filter { $0.attributes.title.en?.lowercased().contains(text.lowercased()) ?? false }
    }
}
