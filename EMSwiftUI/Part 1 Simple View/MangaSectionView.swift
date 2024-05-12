//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    @EnvironmentObject private var viewModel: MangaListViewModel
    
    var sectionName: LocalizedStringKey
    
    private let columns = [GridItem].init(repeating: GridItem(.flexible(), spacing: 25), count: 3)
    
    var body: some View {
        VStack(spacing: 0) {
            MangaSectionTitleView(sectionName: sectionName)
                .padding(.bottom, 16)
            
            if let mangaList = viewModel.mangaList {
                LazyVGrid(columns: columns) {
                    ForEach(mangaList.data, id: \.id) { manga in
                        MangaSingleGridView(manga: manga)
                    }
                }
            }
        }
    }
}
