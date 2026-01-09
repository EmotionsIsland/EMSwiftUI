//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Netify

struct MangaSectionView: View {
    var mangas: [MangaData]
    var sectionTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            MangaSectionTitleView(title: sectionTitle) {
                print("loading more")
            }
            .padding(.bottom, 12)
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 25), GridItem(.flexible(), spacing: 25), GridItem(.flexible())], spacing: 25) {
                ForEach(mangas) { manga in
                    MangaSingleGridView(manga: manga)
                }
            }
        }
    }
}
