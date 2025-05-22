//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var didAppear = false
    @State private var sections: [(String, [MangaData])] = []
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(sections, id: \.0) { title, mangas in
                        MangaSectionView(title: title, mangas: mangas, viewModel: viewModel)
                            .padding(16)
                    }
                }
            }
        }
        .task {
            if !didAppear {
                didAppear = true
                try? await viewModel.getData()
                
                sections = [
                    ("Popular", viewModel.mangaListPopular),
                    ("Recently Added", viewModel.mangaListRecentlyAdded),
                    ("Last Updates", viewModel.mangaListLastUpdates),
                    ("Seasonal", viewModel.mangaListSeasonal)
                ]
            }
        }
    }
}
