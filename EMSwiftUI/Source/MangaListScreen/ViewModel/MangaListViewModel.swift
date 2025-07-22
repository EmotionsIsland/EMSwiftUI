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
    var mangaModel: MangaListModel? { get }
    var imagesArray: [Data?] { get set }
    var isLoading: Bool { get set }
    @MainActor func getData() async
}

final class MangaListViewModelImpl: MangaListViewModel {
    // published
    @Published var mangaModel: MangaListModel?
    @Published var imagesArray: [Data?] = []
    @Published var isLoading = false
    
    private let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
    }
    
    // MARK: getData
    @MainActor func getData() async {
        do {
            isLoading = true
            let result = try await service.getManga()
            self.mangaModel = result
            await loadCovers(for: result.data)
        } catch {
            isLoading = false
            print(error)
        }
    }
    
    // MARK: loadCovers
    @MainActor private func loadCovers(for mangaList: [MangaData]) async {
        do {
            let result = try await withThrowingTaskGroup(of: (Int, Data).self) { group in
                for (index, manga) in mangaList.enumerated() {
                    group.addTask {
                        let data = try await self.service.downloadCoverImage(mangaData: manga, size: .size512)
                        return (index, data)
                    }
                }
                
                var tempArray: [(Int, Data)] = []
                for try await element in group {
                    tempArray.append(element)
                }
                
                let sortedData = tempArray.sorted { $0.0 < $1.0 }.map { $0.1 }
                return sortedData
            }
            
            isLoading = false
            self.imagesArray = result
        } catch {
            isLoading = false
            print("Ошибка загрузки обложек \(error)")
        }
    }
}
