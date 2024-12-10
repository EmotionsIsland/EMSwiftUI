//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let mangaSection: String
    let mangaList: [MangaData]
    var onMoreTapped: () -> ()
    
    var body: some View {
        VStack {
            MangaSectionTitleView(title: mangaSection, onMoreTapped: onMoreTapped)
            MangaSingleGridView(mangaList: mangaList)
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    MangaSectionView()
//}
