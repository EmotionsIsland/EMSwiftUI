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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                SearchBar(searchText: $searchText)
                
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(height: 1)
                
                switch viewModel.screenState {
                case .isLoading:
                    ProgressView().padding(.top, 12)
                case .isLoaded:
                    MangaSectionView(
                        title: "Popular",
                        items: filtered(viewModel.popular),
                        onTapMore: { print("Popular") }
                    )

                    MangaSectionView(
                        title: "Recently Added",
                        items: filtered(viewModel.recentlyAdded),
                        onTapMore: { print("Recently Added") }
                    )
                    
                    MangaSectionView(
                        title: "Last updates",
                        items: filtered(viewModel.lastUpdates),
                        onTapMore: { print("Last updates") }
                    )
                case .failed(let error):
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}
