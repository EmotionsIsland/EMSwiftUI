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
    @Published var state: DataState = .notAvailable
    @Published var hasError: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
    
    func getData() {
        let service = MangaListService(network: Network())
        
        service.getManga()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.state = .failed(error: error)
                case .finished:
                    self.state = .successfull
                }
            }, receiveValue: { [weak self] mangaListModel in
                self?.mangaList = mangaListModel.data
                print(mangaListModel.data.count)
            })
            .store(in: &cancellables)
    }
}
