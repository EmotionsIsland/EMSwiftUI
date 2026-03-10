//
//  TagChipsGrid.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import SwiftUI

struct TagChipsGrid: View {
    let tags: [FilterTag]
    let isSelected: (FilterTag) -> Bool
    let onTap: (FilterTag) -> Void

    var body: some View {
        FlowLayout(spacing: 10) {
            ForEach(tags, id: \.id) { tag in
                TagChipView(
                    title: tag.title,
                    isSelected: isSelected(tag),
                    action: { onTap(tag) }
                )
            }
        }
    }
}
