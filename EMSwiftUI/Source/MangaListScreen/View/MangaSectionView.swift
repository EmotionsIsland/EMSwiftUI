//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let section: MangaSection
    
    var body: some View {
        VStack {
            MangaSectionTitleView(title: section.title)
            
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100), spacing: 25),
                GridItem(.adaptive(minimum: 100), spacing: 25),
                GridItem(.adaptive(minimum: 100), spacing: 25)
            ],
                spacing: 25) {
                ForEach(section.items, id: \.id) { item in
                    MangaSingleGridView(item: item)
                }
            }
        }
    }
}
