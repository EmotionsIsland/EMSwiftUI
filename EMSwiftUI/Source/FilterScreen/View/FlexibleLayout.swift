//
//  FlexibleLayout.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 29.04.2026.
//

import SwiftUI

struct FlexibleLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let content: (Data.Element) -> Content

    init(
        data: Data,
        spacing: CGFloat = 8,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        if #available(iOS 16.0, *) {
            FlowLayoutLayout(spacing: spacing) {
                ForEach(Array(data), id: \.self) { item in
                    content(item)
                }
            }
        } else {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 72), spacing: spacing)],
                alignment: .leading,
                spacing: spacing
            ) {
                ForEach(Array(data), id: \.self) { item in
                    content(item)
                }
            }
        }
    }
}

// MARK: - iOS 16+

@available(iOS 16.0, *)
private struct FlowLayoutLayout: Layout {
    var spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        layout(in: proposal, subviews: subviews).size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = layout(in: proposal, subviews: subviews)
        for (index, subview) in subviews.enumerated() {
            subview.place(
                at: CGPoint(
                    x: bounds.minX + result.frames[index].minX,
                    y: bounds.minY + result.frames[index].minY
                ),
                proposal: ProposedViewSize(result.frames[index].size)
            )
        }
    }

    private func layout(in proposal: ProposedViewSize, subviews: Subviews) -> (frames: [CGRect], size: CGSize) {
        guard !subviews.isEmpty else { return ([], .zero) }

        let maxWidth = proposal.width ?? .infinity
        var frames: [CGRect] = []
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let ideal = subview.sizeThatFits(.unspecified)

            if maxWidth.isFinite, offsetX > 0, offsetX + ideal.width > maxWidth {
                offsetX = 0
                offsetY += lineHeight + spacing
                lineHeight = 0
            }

            frames.append(CGRect(origin: CGPoint(x: offsetX, y: offsetY), size: ideal))
            lineHeight = max(lineHeight, ideal.height)
            offsetX += ideal.width + spacing
        }

        let contentWidth: CGFloat
        if maxWidth.isFinite {
            contentWidth = maxWidth
        } else {
            contentWidth = frames.map(\.maxX).max() ?? 0
        }

        return (frames, CGSize(width: contentWidth, height: offsetY + lineHeight))
    }
}
