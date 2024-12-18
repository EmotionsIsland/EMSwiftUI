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
    
    @Published var mangaList: [MangaData] = []
    @Published var isLoading: Bool = false
    @Published var error: Error? = nil
    
    private(set) var cancellables = Set<AnyCancellable>()
    private let mangaService: MangaListServiceProtocol
    
    init(service: MangaListServiceProtocol = MangaListService(network: Network())) {
        self.mangaService = service
        self.getData()
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
    
    func getData() {
        isLoading = true
        error = nil
        
        mangaService.getManga()
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.error = error
                    self.isLoading = false
                }
            } receiveValue: { [weak self] data in
                self?.mangaList = data
            }
            .store(in: &cancellables)
    }
}
