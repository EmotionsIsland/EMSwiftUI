//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView<VM: MangaListViewModel>: View {
    let title: String
    let mangas: [MangaData]
    let viewModel: VM
    
    private let columns = [
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 25)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            MangaSectionTitleView(title: title) { }
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(mangas.prefix(6)) { manga in
                    MangaSingleGridView(manga: manga, viewModel: viewModel)
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
}
