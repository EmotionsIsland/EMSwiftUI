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
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    MangaSectionView(title: "Popular", mangas: viewModel.popularMangas)
                    MangaSectionView(title: "Last updates", mangas: viewModel.updatedMangas)
                    MangaSectionView(title: "Latest", mangas: viewModel.latestMangas)
                }
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}
