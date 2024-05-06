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
    @Published private(set) var mangs: [MangaData] = []
        
    private let service: MangaListService
    
    private var subscriber = Set<AnyCancellable>()
    
    init(service: MangaListService) {
        self.service = service
        getMangs()
    }
    
    func getMangs() {
        service.getManga()
            .receive(on: DispatchQueue.main)
            .sink { complition in
                switch complition {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] mangs in
                print(mangs.data[0])
                self?.mangs = mangs.data
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
