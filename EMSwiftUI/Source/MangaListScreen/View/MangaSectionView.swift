//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let title: String
    let mangas: [MangaData]
    let viewModel: any MangaListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            MangaSectionTitleView(title: title)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 25) {
                ForEach(mangas[0...5], id: \.id) { manga in
                    MangaSingleGridView(manga: manga, viewModel: viewModel)
                }
            }
        }
    }
}
