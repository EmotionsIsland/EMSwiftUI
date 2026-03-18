import SwiftUI

struct FlowLayout: Layout {
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat
    let alignment: HorizontalAlignment

    init(horizontalSpacing: CGFloat = 8,
         verticalSpacing: CGFloat = 8,
         alignment: HorizontalAlignment = .leading) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.alignment = alignment
    }

    func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews,
                      cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        guard maxWidth.isFinite else {
            return sizeByLayingOut(subviews: subviews, in: .infinity)
        }
        return sizeByLayingOut(subviews: subviews, in: maxWidth)
    }

    func placeSubviews(in bounds: CGRect,
                       proposal: ProposedViewSize,
                       subviews: Subviews,
                       cache: inout ()) {
        let maxWidth = bounds.width
        let layout = lineLayout(for: subviews, maxWidth: maxWidth)

        var currentY = bounds.minY
        for line in layout.lines {
            let lineUsedWidth = line.totalWidth
            let xStart: CGFloat
            switch alignment {
            case .leading:
                xStart = bounds.minX
            case .center:
                xStart = bounds.minX + (maxWidth - lineUsedWidth) / 2
            case .trailing:
                xStart = bounds.minX + (maxWidth - lineUsedWidth)
            default:
                xStart = bounds.minX
            }

            var currentX = xStart
            for item in line.items {
                let size = item.size
                subviews[item.index].place(
                    at: CGPoint(x: currentX, y: currentY),
                    proposal: ProposedViewSize(width: size.width, height: size.height)
                )
                currentX += size.width + horizontalSpacing
            }

            currentY += line.height + verticalSpacing
        }
    }

    private func sizeByLayingOut(subviews: Subviews, in maxWidth: CGFloat) -> CGSize {
        let layout = lineLayout(for: subviews, maxWidth: maxWidth)
        let totalHeight = layout.lines.reduce(0) { partial, line in
            partial + line.height
        } + (layout.lines.isEmpty ? 0 : verticalSpacing * CGFloat(layout.lines.count - 1))

        let usedWidth = layout.lines.map { $0.totalWidth }.max() ?? 0
        let finalWidth = maxWidth.isFinite ? maxWidth : usedWidth
        return CGSize(width: finalWidth, height: totalHeight)
    }

    private func lineLayout(for subviews: Subviews, maxWidth: CGFloat) -> (lines: [Line], totalHeight: CGFloat) {
        var lines: [Line] = []
        var currentItems: [LineItem] = []
        var currentLineWidth: CGFloat = 0
        var currentLineHeight: CGFloat = 0

        func commitLine() {
            guard !currentItems.isEmpty else { return }
            let totalWidth = currentItems.reduce(0) { $0 + $1.size.width } +
            horizontalSpacing * CGFloat(max(0, currentItems.count - 1))
            let line = Line(items: currentItems, height: currentLineHeight, totalWidth: totalWidth)
            lines.append(line)
            currentItems.removeAll()
            currentLineWidth = 0
            currentLineHeight = 0
        }

        for (index, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            let itemWidth = size.width
            let itemHeight = size.height

            let additionalSpacing = currentItems.isEmpty ? 0 : horizontalSpacing
            if currentLineWidth + additionalSpacing + itemWidth > maxWidth, !currentItems.isEmpty {
                commitLine()
            }

            let newLineWidth = (currentItems.isEmpty ? 0 : currentLineWidth + horizontalSpacing) + itemWidth
            currentLineWidth = newLineWidth
            currentLineHeight = max(currentLineHeight, itemHeight)
            currentItems.append(LineItem(index: index, size: CGSize(width: itemWidth, height: itemHeight)))
        }

        commitLine()

        let totalHeight = lines.reduce(0) { $0 + $1.height } +
        (lines.isEmpty ? 0 : verticalSpacing * CGFloat(lines.count - 1))

        return (lines, totalHeight)
    }

    private struct Line {
        let items: [LineItem]
        let height: CGFloat
        let totalWidth: CGFloat
    }

    private struct LineItem {
        let index: Int
        let size: CGSize
    }
}

struct FlexibleGrid<Content: View>: View {
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat
    private let alignment: HorizontalAlignment
    private let content: () -> Content

    init(horizontalSpacing: CGFloat = 8,
         verticalSpacing: CGFloat = 8,
         alignment: HorizontalAlignment = .leading,
         @ViewBuilder content: @escaping () -> Content) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.alignment = alignment
        self.content = content
    }

    var body: some View {
        FlowLayout(
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing,
            alignment: alignment
        ) {
            content()
        }
    }
}
