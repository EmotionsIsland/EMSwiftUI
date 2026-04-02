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

    private func filtered(_ items: [MangaGridItemViewModel]) -> [MangaGridItemViewModel] {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return items }
        return items.filter { $0.title.localizedCaseInsensitiveContains(text) }
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
                    ForEach(viewModel.sections) { section in
                        MangaSectionView(
                            title: section.title,
                            items: section.items,
                            onTapMore: { print(section.title)}
                        )
                    }
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
            await viewModel.loadIfNeeded()
        }
    }
}
