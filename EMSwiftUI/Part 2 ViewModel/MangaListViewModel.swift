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
    @Published private var dataIsLoading: Bool = false
    
    private let mangaListService: MangaListServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(mangaListService: MangaListServiceProtocol =  MangaListService(network: Network())) {
        self.mangaListService = mangaListService
        getData()
    }
    
     func getData() {
        dataIsLoading = true
        mangaListService.getManga()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failed(error: error)
                    self?.dataIsLoading = false
                    print("*** Error in \(#function): \(error)")
                default: break
                }
            } receiveValue: { [weak self] mangaListModel in
                self?.mangaList = mangaListModel.data
                self?.state = .successfull
                self?.dataIsLoading = false
               
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
