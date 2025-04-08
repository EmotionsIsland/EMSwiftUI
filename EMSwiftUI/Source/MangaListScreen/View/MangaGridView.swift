//
//  MangaGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaGridView: View {
    let items: [MangaListItem]
    private let columns: [GridItem] = Array(repeating: GridItem(.fixed(100), spacing: 25), count: 3)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 25, pinnedViews: .sectionHeaders) {
            ForEach(items) { item in
                MangaGridCellView(item: item)
            }
        }
    }
}
