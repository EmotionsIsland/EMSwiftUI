//
//  FlexibleGridView.swift
//  EMSwiftUI
//
//  Created by Halil Yavuz on 17.12.2024.
//

import SwiftUI

struct FlexibleGridView<Content: View>: View {
    let items: [SectionTag]
    let availableWidth: CGFloat
    let content: (SectionTag) -> Content
    
    var body: some View {
        let rows = createFlexibleLayout(in: availableWidth)
        VStack(alignment: .leading, spacing: 8) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack(spacing: 8) {
                    ForEach(rows[rowIndex]) { item in
                        content(item)
                    }
                }
            }
        }
    }
}

private extension FlexibleGridView {
     func createFlexibleLayout(in width: CGFloat) -> [[SectionTag]] {
        var currentRow: [SectionTag] = []
        var rows: [[SectionTag]] = []
        var currentWidth: CGFloat = 0
        
        for item in items {
            let itemWidth: CGFloat = item.name.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 32
            if currentWidth + itemWidth > width {
                rows.append(currentRow)
                currentRow = [item]
                currentWidth = itemWidth
            } else {
                currentRow.append(item)
                currentWidth += itemWidth + 8 
            }
        }
        if !currentRow.isEmpty { rows.append(currentRow) }
        
        return rows
        
    }
}

