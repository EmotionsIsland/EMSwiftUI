//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Factory
import Netify

struct MangaSectionView<VM: MangaListViewModel>: View {
    @ObservedObject var viewModel: VM
    
    private let columns: [GridItem] = {
        var items = Array(repeating: GridItem(.flexible()), count: 3)
        items[0].spacing = 25
        items[1].spacing = 25
        return items
    }()
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding(.top, 8)
            
            Divider()
            contentView
        }
    }
}

private extension MangaSectionView {
    @ViewBuilder
    var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 24) {
                if viewModel.isLoading {
                    loadingView
                } else if let error = viewModel.errorMessage {
                    errorView(error)
                } else {
                    mangaSections
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    var loadingView: some View {
        ProgressView(Strings.loading)
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .padding(.top, 300)
    }
    
    func errorView(_ error: String) -> some View {
        Text(error)
            .foregroundColor(.red)
    }
    
    var mangaSections: some View {
        ForEach(viewModel.mangaTitle, id: \.self) { title in
            MangaSectionContainer(
                title: title,
                mangaList: viewModel.filteredMangaList,
                columns: columns,
                coverURLProvider: { viewModel.getCoverURL(manga: $0, sizeFormat: .size256) }
            )
        }
    }
}

struct MangaSectionContainer: View {
    let title: String
    let mangaList: [MangaData]
    let columns: [GridItem]
    let coverURLProvider: (MangaData) -> URL?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MangaSectionTitleView(title: title)
            
            LazyVGrid(columns: columns) {
                ForEach(mangaList) { manga in
                    MangaItemView(manga: manga, coverURL: coverURLProvider(manga))
                }
            }
        }
    }
}

struct MangaItemView: View {
    let manga: MangaData
    let coverURL: URL?
    
    var body: some View {
        MangaSingleGridView(
            title: manga.attributes.title.en ?? "Untitled",
            description: manga.attributes.tags.first?.attributes.name.en ?? "Unknown",
            coverURL: coverURL
        )
    }
}
