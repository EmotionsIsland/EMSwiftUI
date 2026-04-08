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
            VStack(spacing: 32) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 40)
                    .padding(.top, 10)
                
                if !viewModel.mangas.isEmpty {
                    ForEach(0..<3, id: \.self) { index in
                        MangaSectionView(sectionIndex: index,
                                         title: "Popular",
                                         mangas: viewModel.mangas)
                    }
                } else {
                    ProgressView()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            .task {
                 viewModel.fetchManga()
            }
        }
    }
}
