import SwiftUI
import SwiftUIFlowLayout

struct SelectedFlowLayout<VM: FilterViewModel>: View {
    @ObservedObject var viewModel: VM
    
    var body: some View {
        FlowLayout(mode: .scrollable, items: viewModel.selectedTags, itemSpacing: 0) { tag in
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
