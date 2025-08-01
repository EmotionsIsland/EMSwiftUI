//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let section: MangaSection
    
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 100), spacing: 25), count: 3)
    
    var body: some View {
        VStack {
            MangaSectionTitleView(title: section.title)
            
            LazyVGrid(columns: columns) {
                ForEach(section.items, id: \.id) { item in
                    MangaSingleGridView(item: item)
                }
            }
        }
    }
}
