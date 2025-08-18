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
    var sections: [MangaSection] { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    func fetchData() async
    var viewState: MangaListViewState { get }
}

enum MangaListError: Error {
    case networkError(String)
    case invalidData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return "Ошибка сети \(message)"
        case .invalidData:
            return "Неверный формат данных"
        case .unknown(let error):
            return "Неизвестная ошибка: \(error.localizedDescription)"
        }
    }
}

enum MangaListViewState {
    case loading
    case error(Error)
    case empty
    case success([MangaSection])
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var sections: [MangaSection] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var viewState: MangaListViewState = .loading
    
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor
    private func getData() async throws {
        do {
            let mangaListModel = try await service.getManga()
            sections = [
                MangaSection(title: "Популярное", items: mangaListModel.data),
                MangaSection(title: "Популярное", items: mangaListModel.data),
                MangaSection(title: "Популярное", items: mangaListModel.data)
            ]
        } catch let error as NSError where error.domain == NSURLErrorDomain {
            throw MangaListError.networkError(error.localizedDescription)
        } catch {
            throw MangaListError.unknown(error)
        }
    }
    
    @MainActor
    func fetchData() async {
        if !sections.isEmpty {
            viewState = .success(sections)
            return
        }
        
        isLoading = true
        viewState = .loading
        error = nil
        
        do {
            try await getData()
            viewState = sections.isEmpty ? .empty : .success(sections)
        } catch {
            let mangaError = error as? MangaListError ?? .unknown(error)
            self.error = mangaError
            viewState = .error(mangaError)
            print("Ошибка при получении данных: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}

extension MangaData {
    var coverURL: URL? {
        API.coverURL(for: self)
    }
}
