//
//  FlowLayout.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 23.07.2026.
//

import SwiftUI

struct FlowLayout<Item: Identifiable, Content: View>: View {
    var items: [Item]
    let spacing: CGFloat = 8
    var content: (Item) -> Content

    @State private var sizes: [CGSize] = []
    @State private var containerWidth: CGFloat = 0

    var body: some View {
        let points = layout(sizes: sizes, spacing: spacing, containerWidth: containerWidth)

        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SizeKey.self, value: [proxy.size])
            }
            .frame(height: 0)
            .onPreferenceChange(SizeKey.self) { arr in
                containerWidth = arr.first?.width ?? 0
            }

            ZStack(alignment: .topLeading) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    let point = index < points.count ? points[index] : .zero
                    content(item)
                        .fixedSize()
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(key: SizeKey.self, value: [geo.size])
                            }
                        )
                        .alignmentGuide(.leading) { _ in -point.x }
                        .alignmentGuide(.top) { _ in -point.y }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .onPreferenceChange(SizeKey.self) { prefs in
                sizes = prefs.filter { $0.height > 0 }
            }
        }
    }

    private func layout(sizes: [CGSize], spacing: CGFloat, containerWidth: CGFloat) -> [CGPoint] {
        var result: [CGPoint] = []
        var xCoordinate: CGFloat = 0
        var yCoordinate: CGFloat = 0
        var lineHeight: CGFloat = 0

        for size in sizes {
            if xCoordinate + size.width > containerWidth {
                xCoordinate = 0
                yCoordinate += lineHeight + spacing
                lineHeight = 0
            }

            result.append(.init(x: xCoordinate, y: yCoordinate))

            xCoordinate += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }

        return result
    }
}

private struct SizeKey: PreferenceKey {
    static var defaultValue: [CGSize] = []
    static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
        value.append(contentsOf: nextValue())
    }
}
