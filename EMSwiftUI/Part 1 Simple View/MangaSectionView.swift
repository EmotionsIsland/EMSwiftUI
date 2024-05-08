//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    @ObservedObject var viewModel: MangaListViewModel
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        VStack {
            Section {
                MangaSectionTitleView()
                    .padding(.horizontal)
            }
            
            if let data = viewModel.model {
                LazyVGrid(columns: columns) {
                    ForEach(data.data, id: \.id) { manga in
                        MangaSingleGridView(viewModel: viewModel, model: manga)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    MangaSectionView(viewModel: MangaListViewModel(mangaService: MangaListService(network: Network())))
}
