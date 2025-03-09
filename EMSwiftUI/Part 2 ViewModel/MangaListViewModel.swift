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
    enum State: Equatable {
        case loading, loaded
        case error(description: String)
    }
    
    private let mangaService = MangaListService(network: Network())
    private var cancellable = Set<AnyCancellable>()
    
    // TODO: create Published variables
    @Published var mangaData: [MangaData] = []
    @Published var state: State = .loading
    
    // TODO: create getData func
    func getData() {
        state = .loading
        
        mangaService.getManga()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorCompletion in
                self?.state = .loaded
                if case .failure(let error) = errorCompletion {
                    self?.state = .error(description: error.localizedDescription)
                }
            } receiveValue: { [weak self] model in
                self?.mangaData = model.data
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
