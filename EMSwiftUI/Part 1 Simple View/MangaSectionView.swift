//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let columns = [
        GridItem(.fixed(100), spacing: 25),
        GridItem(.fixed(100), spacing: 25),
        GridItem(.fixed(100), spacing: 25)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MangaSectionTitleView()
            LazyVGrid(columns: columns) {
                ForEach(0..<6, id: \.self) { _ in
                    MangaSingleGridView()
                }
            }
        }
        .padding(.horizontal, 25)
    }
}

#Preview {
    MangaSectionView()
}
