//
//  TagCollectionView.swift
//  EMSwiftUI
//
//  Created by Максим Шишлов on 18.12.2024.
//

import SwiftUI

struct TagCollectionView<Data: Collection, Content: View>: View where Data.Element: Identifiable & Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content

    init(
        data: Data,
        spacing: CGFloat,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }

    var body: some View {
        let rows = computeRows()

        VStack(alignment: alignment, spacing: spacing) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row) { item in
                        content(item)
                    }
                }
            }
        }
    }
}

extension TagCollectionView {
    
    private func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRowWidth: CGFloat = 0
        let maxWidth = UIScreen.main.bounds.width - 16

        for item in data {
            let itemWidth = estimateWidth(for: item)

            if currentRowWidth + itemWidth > maxWidth {
                rows.append([item])
                currentRowWidth = itemWidth + spacing
            } else {
                rows[rows.count - 1].append(item)
                currentRowWidth += itemWidth + spacing
            }
        }
        return rows
    }

    private func estimateWidth(for item: Data.Element) -> CGFloat {
        let label = UILabel()
        if let filterTag = item as? FilterTag {
            label.text = filterTag.name
        } else {
            label.text = "\(item)"
        }
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        return label.frame.width + 48
    }
    
}
