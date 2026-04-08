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
    var mangas: [MangaItemUIModel] { get }
    
    func fetchManga()
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var mangas: [MangaItemUIModel] = []
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    func fetchManga() {
        Task {
            do {
                let data = try await service.getManga()
                await MainActor.run {
                    self.mangas = data.data.map { MangaItemUIModel(manga: $0)}
                }
            } catch {
                print("Ошибка загузки манги:\(error.localizedDescription)")
            }
        }
    }
}
