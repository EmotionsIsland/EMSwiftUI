import SwiftUI

struct DropDownView: View {
    @State private var rotation: Double = 0
    @State private var isExpanded = false
    let category: FilterCategory
    let items: [FilterItem]
    let onSelectAction: (FilterItem) -> Void
    let columns = [GridItem(.flexible(minimum: 100))]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text(category.title)
                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
                    .animation(.easeIn(duration: 0.1), value: isExpanded)
            }
            .animation(.easeIn(duration: 0.1), value: rotation)
            .font(Font.SFPro.lightMedium)
            .onTapGesture {
                withAnimation(.smooth) {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                TagsView(data: items) { element in
                    TagsViewItem(title: element.name, isSelected: element.isSelected)
                        .onTapGesture {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.smooth) {
                                    onSelectAction(element)
                                }
                            }
                        }
                }
                .transition(.opacity)
            }
        }
    }
}
