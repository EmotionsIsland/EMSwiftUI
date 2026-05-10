import SwiftUI

struct FlexibleTagsView: View {
    let tags: [Tag]
    let maxWidth: CGFloat
    let isSelected: (Tag) -> Bool
    let onTap: (Tag) -> Void

    @State private var tagSizes: [String: CGSize] = [:]

    private let layoutService = FlowLayoutService(horizontalSpacing: 8)
    private let verticalSpacing: CGFloat = 8
    
    var body: some View {
        rowsView(maxWidth: maxWidth)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onPreferenceChange(TagSizePreferenceKey.self) { sizes in
                tagSizes = sizes
            }
    }

    private func rowsView(maxWidth: CGFloat) -> some View {
        let tagRows = layoutService.rows(
            items: tags,
            maxWidth: maxWidth,
            sizeProvider: { size(for: $0) }
        )

        return VStack(alignment: .leading, spacing: verticalSpacing) {
            ForEach(tagRows.indices, id: \.self) { rowIndex in
                HStack(spacing: layoutService.horizontalSpacing) {
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

    private func sizeReader(for id: String) -> some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: TagSizePreferenceKey.self, value: [id: geometry.size])
        }
    }

    private func size(for tag: Tag) -> CGSize {
        let selected = isSelected(tag)

        return tagSizes[
            sizeKey(for: tag, isSelected: selected),
            default: layoutService.estimatedSize(title: title(for: tag), isSelected: selected)
        ]
    }

    private func sizeKey(for tag: Tag, isSelected: Bool) -> String {
        layoutService.sizeKey(id: tag.id, isSelected: isSelected)
    }

    private func title(for tag: Tag) -> String {
        tag.attributes.name.english ?? tag.id
    }
}

private struct TagSizePreferenceKey: PreferenceKey {
    static var defaultValue: [String: CGSize] = [:]

    static func reduce(value: inout [String: CGSize], nextValue: () -> [String: CGSize]) {
        value.merge(nextValue(), uniquingKeysWith: { _, newValue in newValue })
    }
}
