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
    
    enum MangaTitle: CaseIterable {
        case popular, latest
        
        var title: String {
            switch self {
            case .popular:
                return "Popular"
            case .latest:
                return "Latest"
            }
        }
    }
    
    private let mangaService = MangaListService(network: Network())
    private var cancellable = Set<AnyCancellable>()
    let mangaTitle = MangaTitle.self
    
    // TODO: create Published variables
    @Published private(set) var mangaData: [MangaData] = []
    @Published private(set) var state: State = .loading
    
    init() { loadDataIfNeeded() }
    
    // TODO: create getData func
    func getData() {
        state = .loading
        
        mangaService.getManga()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorCompletion in
                guard let self else { return }
                
                switch errorCompletion {
                case .finished:
                    state = .loaded
                case .failure(let error):
                    state = .error(description: error.localizedDescription)
                }
            } receiveValue: { [weak self] model in
                guard let self else { return }
                
                mangaData = model.data
            }
            .store(in: &cancellable)
    }
    
    func loadDataIfNeeded() {
        guard mangaData.isEmpty else { return }
        getData()
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
}
