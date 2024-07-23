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
    
    private(set) var errorMessage: String = ""
    
    @Published public var hasError: Bool = false
    @Published public var filterPredicate: String = ""
    @Published private(set) var manga: [MangaData] = []
    @Published private var state: DataState = .notAvailable
   
    var cancellable = Set<AnyCancellable>()
    let networkManager: MangaListServiceProtocol
    var data: [MangaData] = []
    
    public init(networkManager: MangaListServiceProtocol) {
        self.networkManager = networkManager
        
        filterPredicateSubscription()
        setupErrorSubscriptions()
    }
    
}

//MARK: - Extension with public methods

extension MangaListViewModel {
    
    public func fetchData() {
       
        networkManager.getManga()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
            
                switch completion {
                case .finished:
                    debugPrint("Fetch data is finished")
                case .failure(let error):
                    debugPrint("Fetch data is failure with error: \(error.localizedDescription)")
                    state = .failed(error: error)
                }
            } receiveValue: { [unowned self] data in
                self.data = data.data
                manga = data.data
                state = .successfull
            }.store(in: &cancellable)

    }
    
    public func filter(with predicate: String) {
        if predicate.isEmpty {
            manga = data
            return
        }
        
        manga = data.filter {
            guard let title = $0.attributes.title.en else { return false }
            
            return title.contains(predicate)
        }
    }
    
    public func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return URL(string: "")! }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    public func getRating(manga: MangaData) -> URL {
        return Endpoint(path: "/statistics/manga/" + manga.id).url
    }
    
}

//MARK: - Extension with private mrthods

private extension MangaListViewModel {
    
    func filterPredicateSubscription() {
        $filterPredicate.sink { [unowned self] predicate in
            filter(with: predicate)
        }.store(in: &cancellable)
    }
    
}

// MARK: - Error Subscriptions

extension MangaListViewModel {
    func setupErrorSubscriptions() {
        $state
            .map { [unowned self] state -> Bool in
                switch state {
                case .successfull, .notAvailable:
                    return false
                case .failed(let error):
                    errorMessage = error.localizedDescription
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}

