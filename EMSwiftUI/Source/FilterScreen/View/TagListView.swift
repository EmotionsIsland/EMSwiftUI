//
//  TagListView.swift
//  EMSwiftUI
//
//  Created by Ruslan on 26.06.2025.
//

import SwiftUI

struct TagListView: View {
    let tags: [MangaTagRepresentable]
    
    let spacing: CGFloat
    
    let action: (String, Bool) -> Void
    
    var body: some View {
        FlexibleView<[MangaTagRepresentable], TagView>(
            data: tags,
            spacing: 5,
            alignment: .leading,
        ) { tag in
            TagView(name: tag.name, isSelected: tag.isSelected) { bool in
                action(tag.id, bool)
            }
        }
    }
}
