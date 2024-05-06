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

@MainActor
final class MangaListViewModel: ObservableObject {
    @Published var mangaList: MangaListModel?
    @Published var state: DataState = .notAvailable
    
    var hasError: Bool {
        switch state {
        case .successfull:
            false
        case .failed(_):
            true
        case .notAvailable:
            false
        }
    }
    
    private var service: MangaListServiceProtocol
    
    init(service: MangaListServiceProtocol) {
        self.service = service
        getManga()
    }
    
    func getManga() {
        Task {
            let fetchTask = Task.detached(priority: .high) {
                let manga = try await self.service.getManga()
                return manga
            }
            do {
                self.mangaList = try await fetchTask.value
                self.state = .successfull
            } catch {
                self.state = .failed(error: error)
            }
        }
    }
    
    func getCoverURL(manga: MangaData, sizeFormat: SizeFormat) -> URL? {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" } )?.attributes?.fileName else { return nil }
        
        return Endpoint(path: "/covers/" + manga.id + "/" + fileName + sizeFormat.rawValue).coverURL
    }
    
    func getRating(manga: MangaData) async -> Double? {
        let fetchTask = Task.detached {
            return try? await self.service.getRating(manga: manga)
        }
        guard let ratingUpTo10 = await fetchTask.value else { return nil }
        return ratingUpTo10 / 2
    }
}

// MARK: - Error Subscriptions

extension MangaListViewModel {
    ///не, ну я конечно рофлил с ненужного комбайна в нетворке,
    ///но то что тут было это вообще шиза,
    ///задача решается при помощи computed var в одну операцию.
    ///с таким подходом как тут был получается 2 @Published переменных, которые обновляются друг за другом,
    ///что приводит к двойному обновлению интерфейса, что такто расходует ресурсы процессора понапрасну.
    ///не говоря уже о ненужном вывзове  десятка комбайновских функций под капотом, которые можно лицезреть в стактрейсе.
    func setupErrorSubscriptions() {
        print("🤡")
    }
}

