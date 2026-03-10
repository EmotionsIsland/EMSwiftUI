//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let items: [MangaGridItemViewModel]

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 25) {
            ForEach(items) { itemVM in
                MangaGridItemView(vm: itemVM)
            }
        }
    }
}
