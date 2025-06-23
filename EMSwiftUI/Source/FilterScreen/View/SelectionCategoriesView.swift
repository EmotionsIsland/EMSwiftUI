import SwiftUI

struct SelectionCategoriesView<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Divider()
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            
            HStack {
                Text("Selection")
                    .font(.custom("SF-Pro-Text-Bold.otf", size: 20))
                    .foregroundStyle(Color.black)
                
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                FlexibleView(
                    data: viewModel.selectionCategories,
                    spacing: viewModel.spacingBetweenCategories) { item, onLayoutChange in
                        SingleCategoryView(
                            viewModel: viewModel,
                            model: item,
                            onLayoutChange: onLayoutChange)
                    }
            }
            .frame(minHeight: 0, maxHeight: 100)
            
            buttonsStack(
                applyAction: {},
                resetAction: {
                    viewModel.selectionCategories = []})
            
            Divider()
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        }
    }
}

private extension SelectionCategoriesView {
    /// Stack with `Apply` and `Reset` buttons
    func buttonsStack(applyAction: @escaping () -> Void, resetAction: @escaping () -> Void) -> some View {
        return VStack(spacing: 10) {
            Button(action: applyAction) {
                Text("Apply")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.whiteText)
            }
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color.orangeBase)
            .cornerRadius(8)
            
            Button(action: resetAction) {
                Text("Reset")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.black)
            }
        }
    }
}
