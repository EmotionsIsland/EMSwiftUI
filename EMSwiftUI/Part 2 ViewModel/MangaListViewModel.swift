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
    @Published var mangas: [MangaData] = []
    
    private let mangaService: MangaListService
    private var cancellables = Set<AnyCancellable>()
    
    init(mangaService: MangaListService) {
        self.mangaService = mangaService
        getData()
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
    
    func getData() {
        mangaService
            .getManga()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                     print("finished")
                case .failure(_):
                    print("failure")
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                self.mangas = data.data
            }
            .store(in: &cancellables)
    }

    func mangasForGridView(with index: Int) -> [MangaData] {
        let multiplier = index * 2
        let subrange = (0 + multiplier)...(1 + multiplier)
        return Array(mangas[subrange])
    }
}
