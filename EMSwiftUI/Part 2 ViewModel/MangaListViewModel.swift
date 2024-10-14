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

final class MangaListViewModel: ObservableObject {
        
    @Published var mangaData: [CustomMangaModel] = []
    @Published var dataIsLoading: Bool = false
    @Published var hasError: Bool = false
    @Published var state: DataState = .notAvailable
    
    private var subscriber = Set<AnyCancellable>()
    
    private let mangaListService: MangaListService
    
    init(mangaListService: MangaListService) {
        self.mangaListService = mangaListService
        setupErrorSubscriptions()
    }
    
    func getData() {
        dataIsLoading = true
        
        mangaListService
            .getManga()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failed(error: error)
                    self?.dataIsLoading = false
                case .finished:
                    break
                }
            } receiveValue: { [weak self] mangaList in
                let mappedManga = mangaList.data.compactMap { self?.convertManga(manga: $0)}
                self?.mangaData = mappedManga
                self?.state = .successfull
                self?.dataIsLoading = false
            }
            .store(in: &subscriber)
        
        
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
}

private extension MangaListViewModel {
    
    func getMangaTags(tags: [Tag]) -> [String] {
        return tags.compactMap { $0.attributes.name.en ?? "DefaultTag" }
    }
    
    func convertManga(manga: MangaData) -> CustomMangaModel {
        return CustomMangaModel(id: UUID(),
                                title: manga.attributes.title.en ?? "DefaultTitle",
                                imageURL: getCoverURL(manga: manga, sizeFormat: SizeFormat.size256),
                                tags: getMangaTags(tags: manga.attributes.tags))
    }
}

// MARK: - Error Subscriptions

extension MangaListViewModel {
    func setupErrorSubscriptions() {
        $state
            .map { state -> Bool in
                switch state {
                case .successfull, .notAvailable:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}
