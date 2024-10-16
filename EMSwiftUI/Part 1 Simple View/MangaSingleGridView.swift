//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let items: [MangaData]
    
    var body: some View {
        
        LazyVGrid(columns: gridColumns, spacing: 29) {
            ForEach(items) { item in
                MangaSectionView(item: item)
                    .frame(height: 208)
            }
        }
    }
    
    private var gridColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 100))]
    }
}

