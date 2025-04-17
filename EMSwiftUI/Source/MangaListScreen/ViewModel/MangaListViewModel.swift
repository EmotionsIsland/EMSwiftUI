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
    private var cancellables: Set<AnyCancellable> = []

    let headers = ["Popular", "Recently Added"]

    @Published var searchText: String = ""
    @Published private(set) var dataState: DataState = .notAvailable
    @Published private(set) var filteredData: [MangaData] = []

    init(service: MangaListService) {
        self.service = service
        Task {
            await getData()
        }

        configurePipelines()
    }

    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL? {
        API.coverURL(for: manga, sizeFormat)
    }
}

private extension MangaListViewModelImpl {
    @MainActor func getData() async {
        do {
            let result = try await service.getManga()
            mangaData = result.data
            filteredData = result.data
            dataState = .successfull
        } catch {
            dataState = .failed(error: error)
        }
    }

    func configurePipelines() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterMangaData(by: text)
            }
            .store(in: &cancellables)
    }

    func filterMangaData(by text: String) {
        guard !text.isEmpty else {
            filteredData = mangaData
            return
        }
        filteredData = mangaData.filter { $0.attributes.title.en?.lowercased().contains(text.lowercased()) ?? false }
    }
}
