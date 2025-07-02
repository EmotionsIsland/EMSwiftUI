import SwiftUI

struct FilterTagGroupView: View {
    let group: FilterTagGroup
    let selectedTags: Set<FilterTag>
    let onTagTap: (FilterTag) -> Void
    
    @State private var expanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {
                expanded.toggle()
            } label: {
                HStack {
                    Text(group.name)
                    Image(systemName: expanded ? "chevron.up" : "chevron.down")
                }
            }
            .foregroundStyle(.blackBase)
            .font(.SFPro.regularLarge)
            
            if expanded {
                FlexibleLayout(data: group.tags, spacing: 8, alignment: .leading) { tag in
                    FilterTagView(tag: tag, isSelected: selectedTags.contains(tag)) {
                        onTagTap(tag)
                    }
                }
            }
        }
    }
}
