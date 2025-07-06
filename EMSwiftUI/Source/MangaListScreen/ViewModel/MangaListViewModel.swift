//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import UIKit
import Netify

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var data: [MangaPresentationModel] { get }
    func onAppear() async throws
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var data: [MangaPresentationModel] = []
    
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    public func onAppear() async throws {
        do {
            try await getData()
        } catch {
            throw error
        }
    }
    
    // MARK: - Private methods
    @MainActor private func getData() async throws {
        do {
            let mangaList = try await service.getManga()
            let mangaItems = mangaList.data
            
            var presentationModels: [MangaPresentationModel] = []
            
            try await withThrowingTaskGroup(of: MangaPresentationModel.self) { group in
                for manga in mangaItems {
                    group.addTask {
                        let imageData = try await self.service.getCover(for: manga)
                        let image = UIImage(data: imageData)
                        
                        return MangaPresentationModel(
                            id: manga.id,
                            title: manga.attributes.title.en ?? "Undefined",
                            cover: image,
                            rating: 4.3,
                            tags: manga.attributes.tags.compactMap { $0.attributes.name.en })
                    }
                }
                
                for try await model in group {
                    presentationModels.append(model)
                }
                
                self.data = presentationModels
            }
        } catch {
            print("An error occured while loading manga data: \(error.localizedDescription)")
            throw NetworkError.decodingFailed
        }
    }
}
