//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let title: String
    let items: [MangaGridItemViewModel]
    let onTapMore: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            MangaSectionTitleView(title: title, onTapMore: onTapMore)
            MangaSingleGridView(items: items)
        }
    }
}
