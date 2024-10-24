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
    @Published private(set) var state: DataState = .notAvailable
    @Published private(set) var mangaModel: MangaListModel?
    
    private var subscribers = Set<AnyCancellable>()
    private let mangaService: MangaListServiceProtocol
    
    init(mangaService: MangaListServiceProtocol) {
        self.mangaService = mangaService
        self.getManga()
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
    func getManga() {
        mangaService
            .getManga()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    guard let self else { return }
                    self.state = .failed(error: error)
                default:
                    break
                }
            } receiveValue: { [weak self] mangaList in
                guard let self else { return }
                self.state = .successfull
                self.mangaModel = mangaList
            }
            .store(in: &subscribers)
        
    }
}
