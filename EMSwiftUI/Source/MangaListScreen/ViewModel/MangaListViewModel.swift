//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import UIKit
import Netify

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var mangaList: [MangaData] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var mangaTitle: [String] { get }
    func loadCoverImage(for manga: MangaData, size: SizeFormat) async -> UIImage?
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL?
    
    func getData() async throws
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var mangaList: [MangaData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var getRandomRating: CGFloat {
        CGFloat.random(in: 1...5)
    }
    
    var mangaTitle = ["Popular", "Recently Added", "Last Updates", "Seasonal"]
        
    private let service: MangaListService
    
    func fillRatio(for index: Int, rating: CGFloat) -> CGFloat {
        let remainingRating = rating - CGFloat(index)
        return min(max(remainingRating, 0), 1)
    }
    
    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor func getData() async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let data = try await service.getManga()
            self.mangaList = data.data
            print(data)
        } catch {
            self.errorMessage = "Ошибка загрузки: \(error.localizedDescription)"
            throw error
        }
        
        isLoading = false
    }
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat = .size256) -> URL? {
        API.coverURL(for: manga, sizeFormat)
    }
    
    func loadCoverImage(for manga: MangaData, size: SizeFormat = .size512) async -> UIImage? {
            guard let url = API.coverURL(for: manga, size) else {
                return nil
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                return UIImage(data: data)
            } catch {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                return nil
            }
        }
}
