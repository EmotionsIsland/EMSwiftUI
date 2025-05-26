//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView<VM: MangaListViewModel>: View {
    @ObservedObject var viewModel: VM
    let mangas: [MangaData]
    let title: String

    init(viewModel: VM, mangas: [MangaData], title: String) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.mangas = mangas
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            MangaSectionTitleView(title: title)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 25) {
                ForEach(mangas[0...5], id: \.id) { manga in
                    MangaSingleGridView(viewModel: viewModel, manga: manga)
                }
            }
        }
    }
}
