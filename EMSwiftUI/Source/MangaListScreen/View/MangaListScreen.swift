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
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    Text("Search")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    Spacer()
                }
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                Divider()
                    .padding(.bottom)
                
                MangaSectionView(
                    title: "Popular",
                    mangas: Array(viewModel.mangaList.prefix(6)),
                    viewModel: viewModel
                )
                MangaSectionView(
                    title: "Recently Added",
                    mangas: Array(viewModel.mangaList.dropFirst(6).prefix(6)),
                    viewModel: viewModel
                )
                MangaSectionView(
                    title: "Last updates",
                    mangas: Array(viewModel.mangaList.dropFirst(12).prefix(6)),
                    viewModel: viewModel
                )
                MangaSectionView(
                    title: "Seasonal",
                    mangas: Array(viewModel.mangaList.dropFirst(18).prefix(6)),
                    viewModel: viewModel
                )
            }
        }
        .task {
            try? await viewModel.getData()
        }
    }
}
