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
        content
            .task {
                await reload()
            }
            .refreshable {
                await reload()
            }
    }
}

extension MangaListScreen {
    @ViewBuilder
    private var content: some View {
        switch viewModel.loadState {
        case .idle, .loading:
            ProgressView()
        case .failure:
            failureContent
        case .success:
            successContent
        }
    }
    
    private var failureContent: some View {
        LoadingFailureView(errorMessage: "Something went wrong while loading data. Please try again later.") {
            await reload()
        }
    }
    
    private var successContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem()], spacing: 24, pinnedViews: .sectionHeaders) {
                Section {
                    MangaSectionView(mangaList: viewModel.data)
                } header: {
                    MangaSectionTitleView(sectionTitle: "Popular")
                }
                
                Section {
                    MangaSectionView(mangaList: viewModel.data)
                } header: {
                    MangaSectionTitleView(sectionTitle: "Latest")
                }
            }
        }
    }
    
    private func reload() async {
        try? await viewModel.onAppear()
    }
}
