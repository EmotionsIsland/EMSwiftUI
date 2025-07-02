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
            
            FlexibleLayout(data: expanded ? group.tags : Array(group.tags),
                           spacing: 8, alignment: .leading) { tag in
                FilterTagView(tag: tag, isSelected: selectedTags.contains(tag)) {
                    onTagTap(tag)
                }
            }
        }
    }
}

#if DEBUG
struct FilterTagGroupView_Previews: PreviewProvider {
    static var previews: some View {
        let tags = [
            FilterTag(id: "1", name: "Shoujo", group: "genre"),
            FilterTag(id: "2", name: "Josei", group: "genre"),
            FilterTag(id: "3", name: "Seinen", group: "genre"),
            FilterTag(id: "4", name: "Shounen", group: "genre"),
            FilterTag(id: "5", name: "Any", group: "genre"),
            FilterTag(id: "6", name: "None", group: "genre")
        ]
        let group = FilterTagGroup(id: "genre", name: "Genre", tags: tags)
        FilterTagGroupView(group: group, selectedTags: [tags[1], tags[3]]) { _ in }
            .padding()
            .background(Color.white)
    }
}
#endif 
