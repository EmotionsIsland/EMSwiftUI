import SwiftUI

struct FlexibleTagsView: View {
    let tags: [Tag]
    let maxWidth: CGFloat
    let isSelected: (Tag) -> Bool
    let onTap: (Tag) -> Void

    @State private var tagSizes: [String: CGSize] = [:]

    private let horizontalSpacing: CGFloat = 8
    private let verticalSpacing: CGFloat = 8
    
    var body: some View {
        rowsView(maxWidth: maxWidth)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onPreferenceChange(TagSizePreferenceKey.self) { sizes in
                tagSizes = sizes
            }
    }

    private func rowsView(maxWidth: CGFloat) -> some View {
        let tagRows = rows(maxWidth: maxWidth)

        return VStack(alignment: .leading, spacing: verticalSpacing) {
            ForEach(tagRows.indices, id: \.self) { rowIndex in
                HStack(spacing: horizontalSpacing) {
                    ForEach(tagRows[rowIndex]) { tag in
                        let selected = isSelected(tag)

                        TagItemView(
                            title: tag.attributes.name.english ?? tag.id,
                            isSelected: selected,
                            action: { onTap(tag) }
                        )
                        .fixedSize()
                        .background(sizeReader(for: sizeKey(for: tag, isSelected: selected)))
                    }
                }
            }
        }
    }

    private func rows(maxWidth: CGFloat) -> [[Tag]] {
        var rows: [[Tag]] = [[]]
        var currentRowWidth: CGFloat = .zero

        for tag in tags {
            let selected = isSelected(tag)
            let size = tagSizes[sizeKey(for: tag, isSelected: selected), default: estimatedSize(for: tag)]
            let spacing = rows[rows.count - 1].isEmpty ? CGFloat.zero : horizontalSpacing

            if currentRowWidth + spacing + size.width > maxWidth, !rows[rows.count - 1].isEmpty {
                rows.append([tag])
                currentRowWidth = size.width
            } else {
                rows[rows.count - 1].append(tag)
                currentRowWidth += spacing + size.width
            }
        }

        return rows
    }

    private func sizeReader(for id: String) -> some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: TagSizePreferenceKey.self, value: [id: geometry.size])
        }
    }

    private func sizeKey(for tag: Tag, isSelected: Bool) -> String {
        "\(tag.id)-\(isSelected)"
    }

    private func estimatedSize(for tag: Tag) -> CGSize {
        let title = tag.attributes.name.english ?? tag.id
        let selectedIconWidth = isSelected(tag) ? CGFloat(18) : .zero
        let averageCharacterWidth = CGFloat(9)

        return CGSize(
            width: CGFloat(title.count) * averageCharacterWidth + 20 + selectedIconWidth,
            height: 29
        )
    }
}

private struct TagSizePreferenceKey: PreferenceKey {
    static var defaultValue: [String: CGSize] = [:]

    static func reduce(value: inout [String: CGSize], nextValue: () -> [String: CGSize]) {
        value.merge(nextValue(), uniquingKeysWith: { _, newValue in newValue })
    }
}
