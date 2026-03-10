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
    func getData() async
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var mangaList: [MangaData] = []
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor func getData() async {
        do {
            let model = try await service.getManga()
            self.mangaList = model.data
        } catch {
            print("Error fetching manga: \(error)")
        }
    }
}
