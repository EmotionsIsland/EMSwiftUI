//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let sectionTitle: String
    let mangaData: [MangaData]
    @State private var screenWidth: CGFloat = 0
    
    var body: some View {
        VStack {
            MangaSectionTitleView(sectionTitle: sectionTitle)
            mangaGrid
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private let mangaColumns: [GridItem] = [
        GridItem(.flexible(), spacing: Const.Layout.gridPadding),
        GridItem(.flexible(), spacing: Const.Layout.gridPadding),
        GridItem(.flexible())
    ]
    
    private var mangaGrid: some View {
        LazyVGrid(columns: mangaColumns) {
            ForEach(mangaData) { manga in
                MangaSingleGridView(manga: manga, width: screenWidth)
            }
        }
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        screenWidth = (proxy.size.width - 2*Const.Layout.gridPadding)/3
                    }
            }
        )
    }
}
