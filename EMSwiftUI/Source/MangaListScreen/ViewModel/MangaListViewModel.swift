//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Netify
import Combine

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var dataState: DataState { get }
    var mangaData: [MangaData] { get }
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL?
}

final class MangaListViewModelImpl: MangaListViewModel {
    private let service: MangaListService

    @Published var dataState: DataState = .notAvailable
    @Published var mangaData: [MangaData] = []

    init(service: MangaListService) {
        self.service = service
        Task {
            await getData()
        }
    }

    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL? {
        return service.getCoverURL(manga: manga, sizeFormat: sizeFormat)
    }

    @MainActor private func getData() async {
        do {
            let result = try await service.getManga()
            mangaData = result.data
            dataState = .successfull
        } catch {
            dataState = .failed(error: error)
        }
    }
}

enum DataState {
    case successfull
    case failed(error: Error)
    case notAvailable
}
