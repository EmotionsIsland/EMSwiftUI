//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let sectionIndex: Int
    let title: String
    let mangas: [MangaItemUIModel]
    
    let colums = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        VStack {
            MangaSectionTitleView(title: title)
            
            LazyVGrid(columns: colums, spacing: 25) {
                ForEach(mangas) { manga in
                    MangaSingleGridView(item: manga)
                }
            }
        }
    }
}
