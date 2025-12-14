import SwiftUI

struct FilterSectionView<VM: FilterScreenViewModel>: View {
    @State private var isExpanded = false
    let model: FilterSectionModel
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 16) {
                    Text(model.category)
                        .font(Font.SFPro.regularLarge)
                        .foregroundStyle(Color.blackBase)
                    
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .foregroundColor(Color.blackBase)
                        .animation(.easeInOut, value: isExpanded)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 8)
            
            if isExpanded {
                    FlowLayout(items: viewModel.filterSectionModel(at: model.category).tags, spacing: 8) { tag in
                        FilterTagView(tag: tag,
                                      isSelected: true,
                                      action: { _ in
                            viewModel.toggleTag(for: tag, in: model.category)
                        })
                }
                    .padding(.vertical, 8)
            }
        }
        .cornerRadius(12)
    }
}
