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
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let mangaList = viewModel.mangaList?.data {
                    MangaSectionView(title: "Popular", mangas: mangaList, viewModel: viewModel)
                        .padding(16)
                }
            }
        }
        .task {
            if !didAppear {
                didAppear = true
                try? await viewModel.getData()
            }
        }
    }
}
