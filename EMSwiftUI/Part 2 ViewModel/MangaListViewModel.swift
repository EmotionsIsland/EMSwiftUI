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
    // TODO: create Published variables
    // TODO: create getData func
    @Published var mangaData: [MangaData] = []
    @Published var cover: Data?

    let mangaListService: MangaListService
    let operationQueue = OperationQueue.main
    private var subscriber = Set<AnyCancellable>()
    var cancellables = Set<AnyCancellable>()

    init(mangaListService: MangaListService) {
        self.mangaListService = mangaListService

    }

    func loadData() {
        mangaListService
        .getManga()
        .receive(on: operationQueue)
        .sink { [weak self] completion in
          switch completion {
          case .failure(let error):
            print("*** Error in \(#function): \(error)")
          default: break
          }
        } receiveValue: { [weak self] mangaList in
            self?.mangaData = mangaList.data
        }
        .store(in: &subscriber)
    }

//    func loadCover(mangaData: MangaData, sizeFormat: SizeFormat) {
//            let url = getCoverURL(manga: mangaData, sizeFormat: sizeFormat)
//
//            URLSession.shared.dataTaskPublisher(for: url)
//                .map { $0.data }
//                .receive(on: operationQueue)
//                .sink(receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        break
//                    case .failure(let error):
//                        print("Error fetching users: \(error)")
//                    }
//                }, receiveValue: { [weak self] cover in
//                    self?.cover = cover
//                })
//                .store(in: &cancellables)
//        }

    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
}
