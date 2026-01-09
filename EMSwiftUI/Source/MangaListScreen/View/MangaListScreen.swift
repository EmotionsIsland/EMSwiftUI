//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    
    private let categoryOrder: [MangaCategory] = [
        .popular,
        .recentlyAdded,
        .lastUpdated,
        .seasonal
    ]
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .initial, .loading:
                ProgressView()
            case .success:
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 8) {
                        ForEach(categoryOrder, id: \.self) { mangaTitle in
                            if let mangaData = viewModel.mangaByEachCategory[mangaTitle], !mangaData.isEmpty {
                                MangaSectionView(mangas: mangaData, sectionTitle: mangaTitle.rawValue)
                            }
                        }
                    }
                    .padding(16)
                }
                
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}
