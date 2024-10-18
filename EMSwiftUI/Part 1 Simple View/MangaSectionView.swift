//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    
    @State var sectionTitle: String
        
    var mangaListViewModel: MangaListViewModel
    
    private let columns: [GridItem] = [
        GridItem(.fixed(100), spacing: 29),
        GridItem(.fixed(100), spacing: 29),
        GridItem(.fixed(100), spacing: 29)
    ]
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            spacing: 16
        ) {
            Section(
                content: {
                    ForEach(0 ..< ( 1 )) { item in
                        MangaSingleGridView()
                    }
                },
                header: { MangaSectionTitleView(title: sectionTitle)}
            )
        }
    }
}

