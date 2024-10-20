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
    
    @Published var mangaList: MangaListModel?
        
    @Published private(set) var state: DataState = .notAvailable

    let mangaListService: MangaListServiceProtocol
    
    private var cancellable = Set<AnyCancellable>()
    
    init(mangaListService: MangaListServiceProtocol) {
        self.mangaListService = mangaListService
        getData()
    }
    
    func getData() {
        mangaListService
            .getManga()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.state = .failed(error: error)
                }
            }) { [weak self] mangaList in
                self?.mangaList = mangaList
                self?.state = .successfull
            }
            .store(in: &cancellable)
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
}

extension MangaListViewModel {
    func getTagsArray(mangaData: MangaData) -> [String] {
        let tags = mangaData.attributes.tags.compactMap({ $0.attributes.name.en })
        return tags
    }
}
