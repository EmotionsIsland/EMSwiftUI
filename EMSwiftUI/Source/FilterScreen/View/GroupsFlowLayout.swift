import SwiftUI
import SwiftUIFlowLayout

struct GroupsFlowLayout<VM: FilterViewModel>: View {
    let tags: [Tag]
    @ObservedObject var viewModel: VM
    
    var body: some View {
        FlowLayout(mode: .scrollable, items: tags, itemSpacing: 0) { tag in
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
