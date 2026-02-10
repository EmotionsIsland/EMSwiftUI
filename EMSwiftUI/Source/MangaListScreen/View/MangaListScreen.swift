//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var searchText: String = ""
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var filtered: [MangaData] {
        let textToSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !textToSearch.isEmpty else { return viewModel.items }
        
        return viewModel.items.filter {
            ($0.attributes.title.en ?? "")
                .localizedCaseInsensitiveContains(textToSearch)
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                SearchBar(searchText: $searchText)
                
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(height: 1)

                if viewModel.isLoading && viewModel.items.isEmpty {
                    ProgressView().padding(.top, 12)
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }
                
                MangaSectionView(
                    title: "Popular",
                    items: filtered,
                    onTapMore: { print("Popular") }
                )

                MangaSectionView(
                    title: "Recently Added",
                    items: filtered,
                    onTapMore: { print("Recently Added") }
                )
                
                MangaSectionView(
                    title: "Last updates",
                    items: filtered,
                    onTapMore: { print("Last updates") }
                )
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}
