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

    // MARK: - Properties
    @Published private(set) var mangaData: [MangaData] = []
    @Published private(set) var dataState: DataState = .notAvailable
    
    private var cancellables: Set<AnyCancellable> = []
    private let mangaService: MangaListServiceProtocol
    
    // MARK: - Initialization
    init(service: MangaListServiceProtocol) {
        self.mangaService = service
    }
    
    convenience init() {
        self.init(service: MangaListService(network: Network()))
    }
    
    // MARK: - Public Methods
    func getData() {
        dataState = .notAvailable
        
        mangaService.getManga()
            .receive(on: OperationQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.dataState = .successfull
                case .failure(let error):
                    self.dataState = .failed(error: error)
                }
            }, receiveValue: { [weak self] mangaListModel in
                guard let self else { return }
                self.mangaData = mangaListModel.data
            })
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
