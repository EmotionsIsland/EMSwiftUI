//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI
import Factory

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    let gridItem = [GridItem(.adaptive(minimum: 120))]
    
    var body: some View {
        VStack {
            MangaSectionTitleView()
                .padding(.bottom, 16)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    MangaSectionView(title: "Popular")
                        .padding(.horizontal, 16)
                    LazyVGrid(columns: gridItem, spacing: 25) {
                        ForEach(viewModel.mangaModel?.data.indices ?? 0..<0, id: \.self) { index in
                            let manga = viewModel.mangaModel!.data[index]
                            let title = manga.attributes.title.en ?? "No title"
                            let imageData = viewModel.imagesArray[safe: index] ?? Data()
                            let rating: Float = 4.5
                            let maxRating = 5
                            let tag = manga.attributes.tags.first?.attributes.name.en ?? "No tag"
                            
                            MangaSingleGridView(
                                image: imageData ?? Data(),
                                title: title, rating: rating,
                                maxRating: maxRating,
                                tag: tag)
                        }
                    }
                    MangaSectionView(title: "Popular")
                        .padding(.horizontal, 16)
                    LazyVGrid(columns: gridItem, spacing: 25) {
                        ForEach(viewModel.mangaModel?.data.indices ?? 0..<0, id: \.self) { index in
                            let manga = viewModel.mangaModel!.data[index]
                            let title = manga.attributes.title.en ?? "No title"
                            let imageData = viewModel.imagesArray[safe: index] ?? Data()
                            let rating: Float = 4.5
                            let maxRating = 5
                            let tag = manga.attributes.tags.first?.attributes.name.en ?? "No tag"
                            
                            MangaSingleGridView(
                                image: imageData ?? Data(),
                                title: title, rating: rating,
                                maxRating: maxRating,
                                tag: tag)
                        }
                    }
                }
            }
        }
        .overlay(
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(2)
                }
            }
        )
        .task {
            await viewModel.getData()
        }
    }
}

@available(iOS 16.0, *)
#Preview {
    MangaListScreenBuilder.build()
}
