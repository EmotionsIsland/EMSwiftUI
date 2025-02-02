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
    private let service: MangaListServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: MangaListServiceProtocol) {
        self.service = service
        fetchManga()
    }

    func fetchManga() {
        service.getManga()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Ошибка загрузки: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.mangaList = response.data
            })
            .store(in: &cancellables)
    }

    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else {
            return URL(string: "")!
        }
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }

    func getRating(manga: MangaData) -> CGFloat {
        return [4.2, 4.5, 3.0].randomElement() ?? 5.0
    }
}
