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
    
    @Published private(set) var mangaList: [MangaData] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var dataState: DataState = .notAvailable
    
    private let mangaService: MangaListServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: MangaListServiceProtocol = MangaListService(network: Network())) {
        self.mangaService = service
        getData()
    }
    
    func getData() {
        isLoading = true

        mangaService.getManga()
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    guard let self else { return }
                    self.dataState = .failed(error: error)
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                self.mangaList = data
                self.dataState = .successfull
            }
            .store(in: &cancellables)

    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
}
