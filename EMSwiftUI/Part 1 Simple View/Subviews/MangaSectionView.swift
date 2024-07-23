//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    @EnvironmentObject var viewModel: MangaListViewModel
    
    private let columns: [GridItem] = Array(
        repeating: GridItem(.fixed(100), spacing: 29),
        count: 3
    )

    var body: some View {
        VStack {
            MangaSectionTitleView()
                .environmentObject(viewModel)
            LazyVGrid(columns: columns) {
                ForEach(viewModel.manga, id: \.id) { item in
                    NavigationLink {
                        EmptyView()
                    } label: {
                        MangaSingleGridView(image: viewModel.getCoverURL(
                            manga: item, sizeFormat: .size256),
                        viewModel: MangaGridViewModel(data: item))
                    }
                }
            }
            
        }.padding(.horizontal)
    }
}

#Preview {
    MangaSectionView()
        .environmentObject(MangaListViewModel())
}
