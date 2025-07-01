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
    var mangas: [MangaRepresentable] { get set }
    
    var searchText: String { get set }
}

final class MangaListViewModelImpl: MangaListViewModel {
    private let service: MangaListService
    
    @Published var searchText: String = ""
    
    @Published var mangas: [MangaRepresentable] = []
    
    private func getData() {
        Task {
            do {
                let mangaList = try await service.getManga().data
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    mangas = mangaList.compactMap( { self.mapToRepresentable(manga: $0) })
                }
            } catch {
            }
        }
    }
    
    private func mapToRepresentable(manga: MangaData) -> MangaRepresentable {
        let title = manga.attributes.title.en ?? "ERROR"
        
        let genres = manga.attributes.tags.compactMap { $0.attributes.name.en }
        
        let fileName = manga.relationships.first(where: { $0.attributes?.fileName != nil })?.attributes?.fileName
        
        let url = URL(string: "https://uploads.mangadex.org/covers/\(manga.id)/\(fileName ?? "")")
        
        return MangaRepresentable(
            id: manga.id,
            title: title,
            genres: genres,
            imageUrl: url)
    }
    
    init(service: MangaListService) {
        self.service = service
        getData()
    }
    
    @MainActor private func getData() async throws { }
}
