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
    
    let gridItem = [GridItem(.adaptive(minimum: 120))]
    
    var body: some View {
        VStack(spacing: 0) {
            MangaSectionTitleView()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(0..<3) { index in
                        MangaSectionView(title: viewModel.category(index: index))
                            .padding(.horizontal, 16)
                        LazyVGrid(columns: gridItem,
                                  spacing: 25) {
                            if let mangaData = viewModel.mangaModel?.data {
                                ForEach(mangaData) { manga in
                                    MangaSingleGridView(model: viewModel.mangaGridItem(at: manga))
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 16)
            }
        }
        .task {
            await viewModel.getData(refresh: false)
        }
    }
}

#Preview {
    MangaListScreenBuilder.build()
}
