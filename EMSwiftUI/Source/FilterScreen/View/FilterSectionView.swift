import SwiftUI

struct FilterSectionView<VM: TagViewModel>: View {
    let section: TagSection
    @ObservedObject var viewModel: VM
    @State private var isExpanded: Bool = false
    @State private var gridHeight: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(
                action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
            },
                label: {
                    HStack(spacing: 8) {
                        Text(section.title.capitalized)
                            .font(Font.SFPro.regularLarge)
                            .foregroundColor(.blackBase)
                        Image("expandDown")
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .foregroundColor(.blackBase)
                            .animation(.easeInOut, value: isExpanded)
                    }
                }
            )

            if isExpanded {
                FlexibleTagGrid(tags: section.items) { tag in
                    viewModel.toggleTag(tag)
                }
                .frame(height: gridHeight)
                .transition(.opacity)
                .onPreferenceChange(GridHeightPreferenceKey.self) { height in
                    gridHeight = height
                }
            }
        }
    }
}
