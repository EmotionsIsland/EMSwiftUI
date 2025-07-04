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
        if #available(iOS 16.0, *) {
            makeBody()
        }
    }
}

private extension TagListView {
    @ViewBuilder func makeBody() -> some View {
        if #available(iOS 16.0, *) {
            makeFlowLayoutView()
        } else {
            makeFlexbleView()
        }
    }
    
    @ViewBuilder func makeFlexbleView() -> some View {
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
    
    @available(iOS 16.0, *)
    @ViewBuilder func makeFlowLayoutView() -> some View {
        FlowLayout {
            ForEach(tags) {tag in
                TagView(name: tag.name, isSelected: tag.isSelected) { bool in
                    withAnimation {
                        action(tag.id, bool)
                    }
                }
                .padding(4)
            }
        }
    }
}
