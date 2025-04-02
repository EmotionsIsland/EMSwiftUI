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
    
    let columns = [
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding(.top, 8)
            Divider()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .padding(.top, 300)
                    } else if let error = viewModel.errorMessage {
                        Text(error).foregroundColor(.red)
                    } else {
                        ForEach(viewModel.mangaTitle, id: \.self) { title in
                            VStack(alignment: .leading, spacing: 16) {
                                MangaSectionTitleView(title: title)
                                LazyVGrid(columns: columns) {
                                    ForEach(viewModel.filteredMangaList) { manga in
                                        MangaSingleGridView(
                                            title: manga.attributes.title.en ?? "Untitled",
                                            description: manga.attributes.tags.first?.attributes.name.en ?? "Unknown",
                                            coverURL: viewModel.getCoverURL(
                                                manga: manga,
                                                sizeFormat: .size256)
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
//                .onAppear {
//                    Task {
//                        do {
//                            try await viewModel.getData()
//                        } catch {
//                            print("Ошибка при загрузке: \(error.localizedDescription)")
//                        }
//                    }
//                }
            }
        }
    }
}

#Preview {
    MangaSectionView(viewModel: MangaListViewModelImpl(service: MangaListServiceImpl(netify: Container.shared.netify())))
}
