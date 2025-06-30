//
//  TagListView.swift
//  EMSwiftUI
//
//  Created by Ruslan on 26.06.2025.
//

import SwiftUI

struct TagListView: View {
    var tags: [MangaTagRepresentable]
    
    var elementsSize: [MangaTagRepresentable: CGSize] = [:]
    
    @State var width = CGFloat.zero
    
    @State var sizes: [MangaTagRepresentable: CGFloat] = [:]
    
    let spacing: CGFloat
    
    var action: (String, Bool) -> Void = {_,_ in}
    
    var body: some View {
        FlexibleView<[MangaTagRepresentable], FilterTagView>(
            data: tags,
            spacing: 5,
            alignment: .leading,
        ) { tag in
            FilterTagView(name: tag.name, isSelected: tag.isSelected)
        }
    }
}

