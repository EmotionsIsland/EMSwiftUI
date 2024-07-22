//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    //MARK: - Private properties
    
    @EnvironmentObject private var viewModel: MangaListViewModel
    
    private let columns: [GridItem] = [
        GridItem(.fixed(100), spacing: 29),
        GridItem(.fixed(100), spacing: 29),
        GridItem(.fixed(100), spacing: 29)
    ]
    
    //MARK: - UI
    
    var body: some View {
        VStack {
            MangaSectionTitleView()
                .environmentObject(viewModel)
            LazyVGrid(columns: columns) {
                ForEach(viewModel.manga, id: \.id) { item in
                    NavigationLink {
                        EmptyView()
                    } label: {
                        MangaSingleGridView(image: viewModel.getCoverURL(manga: item, sizeFormat: .size256),data: item)
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
