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
    var isLoading: Bool { get set }
    @MainActor func getData() async
    func mangaGridItem(at mangaData: MangaData) -> MangaGridModel
    func category(index: Int) -> String
}

final class MangaListViewModelImpl: MangaListViewModel {
    // published
    @Published var mangaModel: MangaListModel?
    var imagesDict: [String: Data] = [:]
    private let category: [String] = ["Popular", "New", "The Best"]
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
            await loadCovers(for: result.data)
            self.mangaModel = result
        } catch {
            isLoading = false
            print(error)
        }
    }
    
    // MARK: loadCovers
    @MainActor private func loadCovers(for mangaList: [MangaData]) async {
        do {
            let result = try await withThrowingTaskGroup(of: (String, Data).self) { group in
                for manga in mangaList {
                    group.addTask {
                        let data = try await self.service.downloadCoverImage(mangaData: manga, size: .size512)
                        return (manga.id, data)
                    }
                }
                
                var tempDict: [String: Data] = [:]
                for try await (id, data) in group {
                    tempDict[id] = data
                }
                
                return tempDict
            }
            
            isLoading = false
            self.imagesDict = result
        } catch {
            isLoading = false
            print("Ошибка загрузки обложек \(error)")
        }
    }
    
    // MARK: mangaGridItem
    func mangaGridItem(at mangaData: MangaData) -> MangaGridModel {
        let title = mangaData.attributes.title.en ?? "No title"
        let image = imagesDict[mangaData.id] ?? Data()
        let rating: Float = 4.5
        let maxRating = 5
        let tag = mangaData.attributes.tags.first?.attributes.name.en ?? "No tag"
        
        return MangaGridModel(
            image: image,
            title: title,
            rating: rating,
            maxRating: maxRating,
            tag: tag
        )
    }
    
    // MARK: category
    func category(index: Int) -> String {
        return category[safe: index] ?? "No category"
    }
}
