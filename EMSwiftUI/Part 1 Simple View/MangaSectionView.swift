//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

// MARK: - MangaSectionView
struct MangaSectionView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
        
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<25) { _ in
                MangaSingleGridView()
            }
        }
    }
}

#Preview {
    MangaSectionView()
}
