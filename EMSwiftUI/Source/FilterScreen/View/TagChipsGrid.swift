//
//  TagChipsGrid.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import SwiftUI
import SwiftUIFlowLayout

struct TagChipsGrid: View {
    let tags: [FilterTag]
    let isSelected: (FilterTag) -> Bool
    let onTap: (FilterTag) -> Void

    var body: some View {
        FlowLayout(
            mode: .scrollable,
            items: tags,
            itemSpacing: 10
        ) { tag in
            TagChipView(
                title: tag.title,
                isSelected: isSelected(tag),
                action: {onTap(tag)}
            )
        }
    }
}
