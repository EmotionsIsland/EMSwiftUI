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
    var mangaList: [MangaData] { get }
    var sections: [String] { get }
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var mangaList: [MangaData] = []
    
    var sections = ["Popular", "Recently Added", "Last updates"]
    
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
        
        Task {
            try await getData()
        }
    }
    
    @MainActor private func getData() async throws {
        do {
            let result = try await service.getManga()
            self.mangaList = result.data
        } catch {
            print("Ошибка загрузки: \(error)")
        }
    }
}
