//
//  MangaListService.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Combine

protocol MangaListServiceProtocol: AnyObject {
    var network: NetworkProtocol { get }
    
    func getManga() -> AnyPublisher<MangaListModel, Error>
}

final class MangaListService: MangaListServiceProtocol {
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getManga() -> AnyPublisher<MangaListModel, Error> {
        let endpoint = Endpoint.mangaList
        print("\(endpoint.url)")
        
        return network.getData(with: endpoint.url, MangaListModel.self)
    }
}
