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
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 25), count: 3)
    
    var body: some View {
        VStack {
            MangaSectionTitleView(titleText: sectionName) {
            }
            .padding(.vertical, 10)
            
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
        .padding(.horizontal, 15)
    }
}

private extension MangaSectionView {
    func genresString(for manga: MangaData) -> String {
        let genres = manga.attributes.tags.map { $0.attributes.name.en ?? "" }.joined(separator: ", ")
        return genres.isEmpty ? "Unknown" : genres
    }
}
