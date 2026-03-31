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
    var mangas: [MangaData] { get }
    
    func fetchManga()
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var mangas: [MangaData] = []
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor private func getData() async throws {
        let data = try await service.getManga()
        mangas = data.data
    }
    
    func fetchManga() {
        Task {
            do {
               try await getData()
            } catch {
                print("Ошибка загузки манги:\(error.localizedDescription)")
            }
        }
    }
}
