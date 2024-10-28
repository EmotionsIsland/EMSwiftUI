//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    @State var sectionTitle: String
        
    var viewModel: MangaListViewModel
    
    private let columns: [GridItem] = Array(repeating: GridItem(.fixed(100), spacing: 29), count: 3)
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            MangaSectionTitleView(title: sectionTitle)
            
            LazyVGrid(
                columns: columns,
                spacing: 8
            ) {
                if let mangaList = viewModel.mangaList {
                    ForEach(mangaList.data) { item in
                        MangaSingleGridView(
                            mangaData: item,
                            mangaImageUrl: viewModel.getCoverURL(manga: item, sizeFormat: .size256),
                            mangaTags: viewModel.getTagsArray(mangaData: item)
                        )
                    }
                }
            }
        }
    }
}

