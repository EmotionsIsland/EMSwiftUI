//
//  FlowLayout.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import SwiftUI

struct FlowLayout<Data: RandomAccessCollection, Content: View>: View
where Data.Element: Identifiable {
    let items: Data
    let spacing: CGFloat
    let itemWidthProvider: (Data.Element) -> CGFloat
    @ViewBuilder let content: (Data.Element) -> Content

    @State private var containerWidth: CGFloat = 0

    var body: some View {
        let activeWidth = containerWidth > 1 ? containerWidth : UIScreen.main.bounds.width - 32
        let rows = buildRows(items: Array(items), containerWidth: activeWidth)

        VStack(alignment: .leading, spacing: spacing) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack(spacing: spacing) {
                    ForEach(rows[rowIndex], id: \.id) { item in
                        content(item)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            GeometryReader { geo in
                Color.clear.onAppear {
                    containerWidth = geo.size.width
                }
                .onChange(of: geo.size.width) { newWidth in
                    containerWidth = newWidth
                }
            }
        )
        .onChange(of: items.map(\.id)) { _ in
            containerWidth = 0
        }
    }

    private func buildRows(items: [Data.Element], containerWidth: CGFloat) -> [[Data.Element]] {
        var rows: [[Data.Element]] = []
        var currentRow: [Data.Element] = []
        var currentWidth: CGFloat = 0

        for item in items {
            let itemWidth = itemWidthProvider(item)
            let needed = currentRow.isEmpty ? itemWidth : currentWidth + spacing + itemWidth
            if needed > containerWidth, !currentRow.isEmpty {
                rows.append(currentRow)
                currentRow = [item]
                currentWidth = itemWidth
            } else {
                currentRow.append(item)
                currentWidth = currentRow.isEmpty ? itemWidth : currentWidth + spacing + itemWidth
            }
        }
        if !currentRow.isEmpty {
            rows.append(currentRow)
        }
        return rows
    }
}
