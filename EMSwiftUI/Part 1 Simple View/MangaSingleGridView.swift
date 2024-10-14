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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 29) {
            ForEach(items) { item in
                MangaSectionView(item: item)
                    .frame(height: 208)
            }
        }
        .padding(.horizontal, 16)
    }
}
