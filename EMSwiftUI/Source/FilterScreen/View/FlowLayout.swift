//
//  FlowLayout.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import SwiftUI

struct FlowLayout<Item: Identifiable, Content: View>: View {
    var items: [Item]
    var spacing: CGFloat = 8
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
                ForEach(Array(zip(items, items.indices)), id: \.0.id) { item, idx in
                    content(item)
                        .fixedSize()
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(key: SizeKey.self, value: [geo.size])
                            }
                        )
                        .alignmentGuide(.leading) { _ in
                            guard idx < points.count else { return 0 }
                            return -points[idx].x
                        }
                        .alignmentGuide(.top) { _ in
                            guard idx < points.count else { return 0 }
                            return -points[idx].y
                        }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .onPreferenceChange(SizeKey.self) { prefs in
                sizes = prefs
            }
        }
    }

    func layout(sizes: [CGSize], spacing: CGFloat, containerWidth: CGFloat) -> [CGPoint] {
        var result: [CGPoint] = []
        var xCoordinat: CGFloat = 0, yCoordinat: CGFloat = 0, lineHeight: CGFloat = 0

        for size in sizes {
            if xCoordinat + size.width > containerWidth {
                xCoordinat = 0
                yCoordinat += lineHeight + spacing
                lineHeight = 0
            }
            result.append(.init(x: xCoordinat, y: yCoordinat))
            xCoordinat += size.width + spacing
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
