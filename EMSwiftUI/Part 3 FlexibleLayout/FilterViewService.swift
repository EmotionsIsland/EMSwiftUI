//
//  FilterViewService.swift
//  EMSwiftUI
//
//  Created by Evgenii Mikhailov on 17.03.2025.
//

import Foundation
import Combine

protocol FilterViewServiceProtocol: AnyObject {
    var network: NetworkProtocol { get }
    
    func getManga() -> AnyPublisher<MangaListModel, Error>
}

final class FilterViewService: FilterViewServiceProtocol {
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getManga() -> AnyPublisher<MangaListModel, Error> {
        let endpoint = Endpoint.mangaList
        return network.getData(with: endpoint.url, MangaListModel.self)
    }
}
