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
                VStack(spacing: 16) {
                    ForEach(0..<3) { index in
                        MangaSectionView(title: viewModel.category(index: index))
                            .padding(.horizontal, 16)
                        LazyVGrid(columns: gridItem, spacing: 25) {
                            ForEach(viewModel.mangaModel?.data.indices ?? 0..<0, id: \.self) { index in
                                if let model = viewModel.mangaGridItem(at: index) {
                                    MangaSingleGridView(model: model)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
        }
        .overlay(
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.grayBase))
                        .scaleEffect(2)
                }
            }
        )
        .task {
            await viewModel.getData()
        }
    }
}

#Preview {
    MangaListScreenBuilder.build()
}
