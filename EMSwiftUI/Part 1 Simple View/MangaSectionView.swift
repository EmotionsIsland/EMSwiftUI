//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let mangaSection: String
    let mangas: [MangaData]
    var moreButton: () -> Void
    var coverURL: (MangaData) -> URL
    
    var body: some View {
        VStack {
            MangaSectionTitleView(title: mangaSection, moreButton: moreButton)
                .padding(.top, 24)
            MangaSingleGridView(mangas: mangas, coverURL: coverURL)
        }
        .padding(.horizontal, 16)
    }
}


