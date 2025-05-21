import SwiftUI

struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    let items: Data
    let itemSpacing: CGFloat
    let content: (Data.Element) -> Content
    
    init(items: Data, itemSpacing: CGFloat = 8, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.items = items
        self.itemSpacing = itemSpacing
        self.content = content
    }
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(items) { item in
                content(item)
                    .padding(.all, itemSpacing)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if abs(width - dimension.width) > UIScreen.main.bounds.width - 16 {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if item.id == items.last?.id {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if item.id == items.last?.id {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .frame(alignment: .topLeading)
    }
}

struct SelectedFlowLayout<VM: FilterViewModel>: View {
    @ObservedObject var viewModel: VM
    
    var body: some View {
        FlowLayout(items: viewModel.selectedTags, itemSpacing: 0) { tag in
            let title = tag.attributes.name.en ?? "Unknown"
            
            Text("＋ \(title)")
                .frame(minHeight: 36)
                .fixedSize(horizontal: true, vertical: true)
                .padding(.horizontal, 8)
                .font(Font.SFPro.bodyNormal)
                .foregroundStyle(.white)
                .background(Color.orangeBase)
                .cornerRadius(8)
                .padding([.trailing, .bottom], 8)
                .onTapGesture {
                    withAnimation {
                        viewModel.toggleSelection(for: tag)
                    }
                }
        }
    }
}

struct GroupsFlowLayout<VM: FilterViewModel>: View {
    let tags: [Tag]
    @ObservedObject var viewModel: VM
    
    var body: some View {
        FlowLayout(items: tags, itemSpacing: 0) { tag in
            let title = tag.attributes.name.en ?? "Unknown"
            
            Text(viewModel.isSelected(tag) ? "＋ \(title)" : title)
                .frame(minHeight: 36)
                .fixedSize(horizontal: true, vertical: true)
                .padding(.horizontal, 8)
                .font(Font.SFPro.bodyNormal)
                .foregroundStyle(viewModel.isSelected(tag) ? .white : Color.black)
                .background(viewModel.isSelected(tag) ? Color.orangeBase : Color.grayBase)
                .cornerRadius(8)
                .padding([.trailing, .bottom], 8)
                .onTapGesture {
                    withAnimation {
                        viewModel.toggleSelection(for: tag)
                    }
                }
        }
    }
}
