//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var loadState: LoadState = .idle
    
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
    enum LoadState {
        case idle, loading, success, failure(Error)
    }
    
    @ViewBuilder
    private var content: some View {
        switch loadState {
        case .idle, .loading:
            ProgressView()
        case .failure:
            VStack(spacing: 12) {
                Text("Something went wrong while loading data. Please try again later.")
                    .font(.SFPro.semiboldNormal)
                    .multilineTextAlignment(.center)
                    .padding()
                Button("Try again") {
                    Task {
                        await reload()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        case .success:
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
    }
    
    private func reload() async {
        loadState = .loading
        do {
            try await viewModel.onAppear()
            loadState = .success
        } catch {
            loadState = .failure(error)
        }
    }
}
