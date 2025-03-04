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
    
    private let mangaService: MangaListServiceProtocol
    private var subscriber = Set<AnyCancellable>()
    
    @Published var state: DataState = .notAvailable
    @Published var hasError: Bool = false
    @Published var dataIsLoading: Bool = false
    @Published var manga: MangaListModel = MangaListModel.mock
    
    init(mangaService: MangaListServiceProtocol){
        self.mangaService = mangaService
        
        getData()
        setupErrorSubscriptions()
    }
    
    func getData() {
        mangaService
            .getManga()
            .receive(on: OperationQueue.main)
            .sink { [weak self] completion in
                switch completion{
                case .finished:
                    print("Success!")
                    break
                case .failure(let error):
                    self?.state = .failed(error: error)
                    self?.dataIsLoading = false
                    print("*** Error in \(#function): \(error)")
                }
            } receiveValue: { [weak self] manga in
                self?.manga = manga
                self?.state = .successfull
                self?.dataIsLoading = false
            }
            .store(in: &subscriber)
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL? {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "") }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
}

// MARK: - Error Subscriptions

extension MangaListViewModel {
    func setupErrorSubscriptions() {
        $state
            .map { state -> Bool in
                switch state {
                case .successfull, .notAvailable:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}
