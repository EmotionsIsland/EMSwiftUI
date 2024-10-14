//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 25), count: 3)
    
    let mangas: [CustomMangaModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            MangaSectionTitleView(title: "Popular", action: {})
            
            LazyVGrid(columns: columns, spacing: 8)  {
                ForEach(mangas) { manga in
                    MangaSingleGridView(manga: manga)
                }
            }
        }
    }
}
