import CoreGraphics

struct FlowLayoutService {
    let horizontalSpacing: CGFloat

    private let averageCharacterWidth: CGFloat = 9
    private let horizontalContentPadding: CGFloat = 20
    private let selectedIconWidth: CGFloat = 18
    private let defaultHeight: CGFloat = 29

    init(horizontalSpacing: CGFloat) {
        self.horizontalSpacing = horizontalSpacing
    }

    func rows<Item>(
        items: [Item],
        maxWidth: CGFloat,
        sizeProvider: (Item) -> CGSize
    ) -> [[Item]] {
        var rows: [[Item]] = [[]]
        var currentRowWidth: CGFloat = .zero

        for item in items {
            let itemSize = sizeProvider(item)
            let spacing = rows[rows.count - 1].isEmpty ? CGFloat.zero : horizontalSpacing

            if currentRowWidth + spacing + itemSize.width > maxWidth, !rows[rows.count - 1].isEmpty {
                rows.append([item])
                currentRowWidth = itemSize.width
            } else {
                rows[rows.count - 1].append(item)
                currentRowWidth += spacing + itemSize.width
            }
        }

        return rows
    }

    func sizeKey(id: String, isSelected: Bool) -> String {
        "\(id)-\(isSelected)"
    }

    func estimatedSize(title: String, isSelected: Bool) -> CGSize {
        let iconWidth = isSelected ? selectedIconWidth : .zero

        return CGSize(
            width: CGFloat(title.count) * averageCharacterWidth + horizontalContentPadding + iconWidth,
            height: defaultHeight
        )
    }
}
