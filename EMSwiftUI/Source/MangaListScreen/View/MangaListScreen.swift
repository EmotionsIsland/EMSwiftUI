//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @Binding private var searchText: String
    
    init(viewModel: VM, searchText: Binding<String>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _searchText = searchText
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 40) {
                ForEach(viewModel.filteredSections(for: searchText)) { section in
                    MangaSectionView(title: section.title) {
                        ForEach(section.mangaList) { item in
                            MangaSingleGridView(item: item)
                        }
                    }
                }
            }
            .padding(.vertical, 16)
        }
        .task {
            await viewModel.getData()
        }
    }
}
