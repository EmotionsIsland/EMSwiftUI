//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            searchBar
            ScrollView(.vertical, showsIndicators: false) {
                switch viewModel.viewState {
                case .loading, .initial:
                    ProgressView("Loading")
                case .loaded:
                    MangaSectionView(title: "Popular", mangaList: viewModel.popularMangas)
                    MangaSectionView(title: "Recently Added", mangaList: viewModel.recentlyAddedMangas)
                    MangaSectionView(title: "Last updates", mangaList: viewModel.lastUpdatedMangas)
                case .error(let error):
                    errorView(error)
                }
            }
            .task {
                await viewModel.loadData()
            }
        }
    }

    var searchBar: some View {
        HStack(spacing: 4) {
            Image(.search)
            TextField("Search", text: .constant(""  ))
                .font(.SFPro.lightSmall)
            Spacer()
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 6)
        .background(.whiteText)
        .foregroundStyle(.grayBase)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 16)
        .bottomSeparator()
    }

    private func errorView(_ error: Error) -> some View {
        VStack {
            Text("Ошибка: \(error.localizedDescription)")
            Button("Повторить") {
                Task {
                    await viewModel.retry()
                }
            }
        }
    }
}
