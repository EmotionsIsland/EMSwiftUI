//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    
    let sectionName: String
    let mangas: [MangaData]
    
    init(viewModel: VM,
         sectionName: String,
         mangas: [MangaData]) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.sectionName = sectionName
        self.mangas = mangas
    }
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25)
    ]
    
    var body: some View {
        VStack {
            MangaSectionTitleView(titleText: sectionName) {
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            
            LazyVGrid(columns: columns, spacing: 25) {
                ForEach(mangas, id: \.id) { manga in
                    MangaSingleGridView(
                        imageURL: viewModel.getMangaCoverURL(for: manga, .size512),
                        title: manga.attributes.title.en ?? "",
                        rating: 4.2,
                        genres: genresString(for: manga))
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }
}

private extension MangaSectionView {
//    func coverURL(for manga: MangaData) -> String {
//        let baseURL = "https://uploads.mangadex.org/covers/"
//        if let cover = manga.relationships.first(where: { $0.type == "cover_art" }),
//           let fileName = cover.attributes?.fileName {
//            return baseURL + manga.id + "/" + fileName
//        }
//        return "https://via.placeholder.com/300x450.png?text=No+Image"
//    }

    func genresString(for manga: MangaData) -> String {
        let genres = manga.attributes.tags.map { $0.attributes.name.en ?? "" }.joined(separator: ", ")
        return genres.isEmpty ? "Unknown" : genres
    }
}
