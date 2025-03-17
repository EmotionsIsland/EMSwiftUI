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
    
    private var cancellables: Set<AnyCancellable> = []
    private let mangaService: MangaListServiceProtocol
    // TODO: create Published variables
    @Published var mangaData: [MangaData] = []
    
    init(mangaService: MangaListServiceProtocol) {
        self.mangaService = mangaService
        getData()
    }
    // TODO: create getData func
    private func getData() {
        mangaService.getManga()
            .receive(on: DispatchQueue.main)
            .sink { comp in
                switch comp {
                case .failure(let error):
                    print ("Error: \(error)")
                default:
                    break
                }
            } receiveValue: { [weak self] mangas in
                guard let self else { return }
                self.mangaData = mangas.data
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
