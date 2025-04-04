import SwiftUI

struct DropDownView: View {
    @State private var rotation: Double = 0
    @State private var isExpanded = false
    let category: FilterCategory
    let items: [FilterItem]
    let onSelectAction: (FilterItem) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {
                withAnimation(.smooth) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 8) {
                    Text(category.title)
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .animation(.easeIn(duration: 0.1), value: isExpanded)
                    Spacer()
                }
                .animation(.easeIn(duration: 0.1), value: rotation)
                .font(Font.SFPro.lightMedium)
            }
            
            if isExpanded {
                TagsView(data: items) { element in
                    TagsViewItem(title: element.name, isSelected: element.isSelected) {
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
