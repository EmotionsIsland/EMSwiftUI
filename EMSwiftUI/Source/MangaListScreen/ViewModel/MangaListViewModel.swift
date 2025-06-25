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

enum Season: String, CaseIterable {
    case winter = "Winter"
    case spring = "Spring"
    case summer = "Summer"
    case fall   = "Fall"
}

protocol MangaListViewModel: ObservableObject {
    var mangaModel: MangaListModel? { get set }
    func getMangaCoverURL(for mangaData: MangaData, _ sizeFormat: SizeFormat) -> URL?
    func sortByRecent() -> [MangaData]
    func sortByLastUpdated() -> [MangaData]
    func sortBySeason(season targetSeason: Season) -> [MangaData]
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var mangaModel: MangaListModel?
    
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
        Task {
            try? await getData()
            await print(mangaModel)
        }
    }
    
    @MainActor private func getData() async throws {
        mangaModel = try await service.getManga()
    }
}

// MARK: - Get Cover Method
extension MangaListViewModelImpl {
    func getMangaCoverURL(for mangaData: MangaData, _ sizeFormat: SizeFormat = .size512) -> URL? {
        return service.getMangaCoverURL(for: mangaData, sizeFormat)
    }
}

// MARK: - Sorts
extension MangaListViewModelImpl {
    func sortByRecent() -> [MangaData] {
        let dateFormatter = ISO8601DateFormatter()
        let mangas = mangaModel?.data ?? []
        
        return mangas.sorted {
            guard let date1 = dateFormatter.date(from: $0.attributes.createdAt),
                  let date2 = dateFormatter.date(from: $1.attributes.createdAt) else {
                return false
            }
            return date1 > date2
        }
    }

    func sortByLastUpdated() -> [MangaData] {
        let dateFormatter = ISO8601DateFormatter()
        let mangas = mangaModel?.data ?? []
        
        return mangas.sorted {
            guard let date1 = dateFormatter.date(from: $0.attributes.updatedAt),
                  let date2 = dateFormatter.date(from: $1.attributes.updatedAt) else {
                return false
            }
            return date1 > date2
        }
    }
    
    func sortBySeason(season targetSeason: Season) -> [MangaData] {
        let dateFormatter = ISO8601DateFormatter()
        let mangas = mangaModel?.data ?? []
        
        return mangas.sorted {
            guard let date1 = dateFormatter.date(from: $0.attributes.createdAt),
                  let date2 = dateFormatter.date(from: $1.attributes.createdAt) else { return false }
            
            let season1 = season(from: date1)
            let season2 = season(from: date2)
            
            if season1 == targetSeason && season2 != targetSeason {
                return true
            } else if season1 != targetSeason && season2 == targetSeason {
                return false
            } else {
                return date1 > date2
            }
        }
    }
}

// MARK: - Private methods
private extension MangaListViewModelImpl {
    func season(from date: Date) -> Season {
        let month = Calendar.current.component(.month, from: date)
        
        switch month {
        case 1...3:
            return .winter
        case 4...6:
            return .spring
        case 7...9:
            return .summer
        default:
            return .fall
        }
    }
}
