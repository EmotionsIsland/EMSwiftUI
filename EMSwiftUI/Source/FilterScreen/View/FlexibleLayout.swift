//
//  FlexibleLayout.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 12.05.2026.
//

import SwiftUI

struct FlexibleLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    let data: Data
    let spacing: CGFloat
    let rowSpacing: CGFloat
    private let content: (Data.Element) -> Content

    @State private var chipWidths: [Data.Element.ID: CGFloat] = [:]
    @State private var containerWidth: CGFloat = 0

    init(
        data: Data,
        spacing: CGFloat,
        rowSpacing: CGFloat? = nil,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.spacing = spacing
        self.rowSpacing = rowSpacing ?? spacing
        self.content = content
    }

    var body: some View {
        let items = Array(data)
        let screenCap = UIScreen.main.bounds.width - 32
        let raw = containerWidth > 1 ? containerWidth : screenCap
        let maxWidth = max(1, min(raw, screenCap))
        let rows = Self.buildRows(
            items: items,
            widths: chipWidths,
            maxWidth: maxWidth,
            spacing: spacing,
            fallbackChipWidth: 72
        )

        VStack(alignment: .leading, spacing: rowSpacing) {
            ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
                HStack(alignment: .center, spacing: spacing) {
                    ForEach(row, id: \.id) { item in
                        content(item)
                            .fixedSize(horizontal: true, vertical: false)
                            .background(widthMeasure(for: item))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            GeometryReader { geo in
                Color.clear.preference(key: ContainerWidthPreference.self, value: geo.size.width)
            }
        )
        .onPreferenceChange(ContainerWidthPreference.self) { width in
            if width > 0, abs(width - containerWidth) > 0.5 {
                containerWidth = width
            }
        }
        .onPreferenceChange(ChipWidthPreference<Data.Element.ID>.self) { chipWidths = $0 }
        .onChange(of: Array(data.map(\.id))) { _ in
            chipWidths = [:]
            containerWidth = 0
        }
    }

    private func widthMeasure(for item: Data.Element) -> some View {
        GeometryReader { geo in
            Color.clear.preference(
                key: ChipWidthPreference<Data.Element.ID>.self,
                value: [item.id: geo.size.width]
            )
        }
    }
}

private extension FlexibleLayout {
    static func buildRows(
        items: [Data.Element],
        widths: [Data.Element.ID: CGFloat],
        maxWidth: CGFloat,
        spacing: CGFloat,
        fallbackChipWidth: CGFloat
    ) -> [[Data.Element]] {
        guard !items.isEmpty else { return [] }

        var rows: [[Data.Element]] = []
        var row: [Data.Element] = []
        var rowUsed: CGFloat = 0

        for item in items {
            let chipW = widths[item.id] ?? fallbackChipWidth
            let extra = row.isEmpty ? chipW : spacing + chipW

            if rowUsed + extra > maxWidth, !row.isEmpty {
                rows.append(row)
                row = [item]
                rowUsed = chipW
            } else {
                row.append(item)
                rowUsed += row.count == 1 ? chipW : spacing + chipW
            }
        }
        if !row.isEmpty {
            rows.append(row)
        }
        return rows
    }
}

private struct ChipWidthPreference<ID: Hashable>: PreferenceKey {
    static var defaultValue: [ID: CGFloat] { [:] }

    static func reduce(value: inout [ID: CGFloat], nextValue: () -> [ID: CGFloat]) {
        for (key, width) in nextValue() where width > 1 {
            value[key] = max(value[key] ?? 0, width)
        }
    }
}

private struct ContainerWidthPreference: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        let next = nextValue()
        if next > 0 {
            value = next
        }
    }
}
