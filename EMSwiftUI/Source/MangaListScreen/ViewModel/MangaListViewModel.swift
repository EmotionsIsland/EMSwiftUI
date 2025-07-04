//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Netify

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var popularMangas: [MangaRepresentable] { get set }
    
    var latestMangas: [MangaRepresentable] { get set }
    
    var updatedMangas: [MangaRepresentable] { get set }
    
    var searchText: String { get set }
}

final class MangaListViewModelImpl: MangaListViewModel {
    private let service: MangaListService
    
    @Published var searchText: String = ""
    
    @Published var popularMangas: [MangaRepresentable] = []
    
    @Published var latestMangas: [MangaRepresentable] = []
    
    @Published var updatedMangas: [MangaRepresentable] = []
    
    @MainActor private func getData() async throws {
        Task {
            do {
                let popularMangas = try await service.getManga(order: .popular).data
                self.popularMangas = popularMangas.compactMap( { self.mapToRepresentable(manga: $0) })
                
                let updatedMangas = try await  service.getManga(order: .updated).data
                self.updatedMangas = updatedMangas.compactMap( { self.mapToRepresentable(manga: $0) })
                
                let latestMangas = try await service.getManga(order: .latest).data
                self.latestMangas = latestMangas.compactMap( { self.mapToRepresentable(manga: $0) })
            } catch {
                throw(error)
            }
        }
    }
    
    private func mapToRepresentable(manga: MangaData) -> MangaRepresentable {
        let title = manga.attributes.title.en ?? "No EN name"
        
        let genres = manga.attributes.tags.compactMap { $0.attributes.name.en }
        
        let url = API.coverURL(for: manga)
        
        return MangaRepresentable(
            id: manga.id,
            title: title,
            genres: genres,
            imageUrl: url)
    }
    
    init(service: MangaListService) {
        self.service = service
        Task {
            try? await getData()
        }
    }
}
