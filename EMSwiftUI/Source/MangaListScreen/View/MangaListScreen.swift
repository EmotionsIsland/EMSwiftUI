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
            searchBar
            MangaSectionView(title: "Popular", mangaList: viewModel.popularMangas)
            MangaSectionView(title: "Recently Added", mangaList: viewModel.recentlyAddedMangas)
            MangaSectionView(title: "Last updates", mangaList: viewModel.lastUpdatedMangas)
        }
        .task {
            await viewModel.loadData()
        }
    }

    var searchBar: some View {
        HStack(spacing: 4) {
            Image(.search)
            TextField("Search", text: .constant(""  ))
                .font(.SFPro.lightSmall)
            Spacer()
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 6)
        .background(.whiteText)
        .foregroundStyle(.grayBase)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        .overlay(alignment: .bottom) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.grayBase)
        }
    }
}
