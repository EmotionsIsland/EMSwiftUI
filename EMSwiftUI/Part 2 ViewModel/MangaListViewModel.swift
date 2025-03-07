//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Combine

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

enum MangaSortKey: String, CaseIterable {
    case popular = "Popular"
    case new = "Recently Added"
    case updated = "Last updates"
    case season = "Seasonal"
}

final class MangaListViewModel: ObservableObject {
    @Published var mangaList: [MangaData] = []
    @Published var mangaRatingList: [String: Double] = [:]
    
    private let service: MangaListService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: MangaListService) {
        self.service = service
        getData()
    }
    
    func getData() {
        service.getManga()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { complection in
                switch complection {
                case .failure(let error):
                    print("Ошибка загрузки: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                self.mangaList = response.data
                getRating()
            })
            .store(in: &cancellables)
    }
    
    // используется для создания моковых данных рейтинга
    func getRating() {
        mangaRatingList = mangaList.reduce(into: [:]) { result, manga in
            result[manga.id] = Double.random(in: 0..<5)
        }
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
    
    // функция возвращает данные рейтинга
    // для конкретной манги
    func getRating(manga: MangaData) -> Double {
        mangaRatingList[manga.id] ?? 0
    }
    
    // функция сортировки по различным критериям
    func getSortedData(by key: MangaSortKey) -> [MangaData] {
        switch key {
        case .popular:
            mangaList.sorted(by: compareRatings)
        case .new:
            mangaList.sorted(by: {$0.attributes.createdAt > $1.attributes.createdAt})
        case .updated:
            mangaList.sorted(by: {$0.attributes.updatedAt > $1.attributes.updatedAt})
        case .season:
            mangaList
        }
    }
    
    private func compareRatings(lhs: MangaData, rhs: MangaData) -> Bool {
        let lhsRating = mangaRatingList[lhs.id] ?? 0.0
        let rhsRating = mangaRatingList[rhs.id] ?? 0.0
        return lhsRating > rhsRating
    }
}
