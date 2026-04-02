//
//  FlowLayout.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 10.03.2026.
//

import SwiftUI

struct FlowLayout<Item: Identifiable, Content: View>: View {
    let items: [Item]
    let content: (Item) -> Content

    @State private var sizes: [CGSize] = []
    @State private var containerWidth: CGFloat = 0

    var body: some View {
        let points = layout(
            sizes: sizes,
            spacing: 8,
            containerWidth: containerWidth
        )

        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: ContainerSizeKey.self, value: [proxy.size])
            }
            .frame(height: 0)
            .onPreferenceChange(ContainerSizeKey.self) { value in
                containerWidth = value.first?.width ?? 0
            }

            ZStack(alignment: .topLeading) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    content(item)
                        .fixedSize()
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: ItemSizeKey.self, value: [geo.size])
                            }
                        )
                        .alignmentGuide(.leading) { _ in
                            guard index < points.count else { return 0 }
                            return -points[index].x
                        }
                        .alignmentGuide(.top) { _ in
                            guard index < points.count else { return 0 }
                            return -points[index].y
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onPreferenceChange(ItemSizeKey.self) { value in
                sizes = value
            }
        }
    }

    private func layout(
        sizes: [CGSize],
        spacing: CGFloat,
        containerWidth: CGFloat
    ) -> [CGPoint] {
        var result: [CGPoint] = []
        var xAxis: CGFloat = 0
        var yAxis: CGFloat = 0
        var lineHeight: CGFloat = 0

        for size in sizes {
            if xAxis + size.width > containerWidth {
                xAxis = 0
                yAxis += lineHeight + spacing
                lineHeight = 0
            }

            result.append(CGPoint(x: xAxis, y: yAxis))
            xAxis += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }

        return result
    }
}

private struct ContainerSizeKey: PreferenceKey {
    static var defaultValue: [CGSize] = []

    static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
        value.append(contentsOf: nextValue())
    }
}

private struct ItemSizeKey: PreferenceKey {
    static var defaultValue: [CGSize] = []

    static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
        value.append(contentsOf: nextValue())
    }
}
