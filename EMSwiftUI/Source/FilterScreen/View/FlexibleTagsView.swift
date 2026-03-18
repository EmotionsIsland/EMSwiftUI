import SwiftUI

struct FlexibleTagsView: View {
    let tags: [Tag]
    let isSelected: (Tag) -> Bool
    let onTap: (Tag) -> Void
    
    var body: some View {
        FlexibleGrid {
            ForEach(tags) { tag in
                TagItemView(
                    title: tag.attributes.name.english ?? tag.id,
                    isSelected: isSelected(tag),
                    action: { onTap(tag) }
                )
            }
        }
    }
}
