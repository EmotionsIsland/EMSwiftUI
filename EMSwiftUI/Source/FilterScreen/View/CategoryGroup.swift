import SwiftUI

struct CategoryGroup<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var isExpanded = false
    let title: String
    let data: [TagData]
    
    init(
        viewModel: VM,
        title: String,
        data: [TagData]) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.title = title
        self.data = data
    }
    
    var body: some View {
        VStack {
            titleButton(title: title)
            
            if isExpanded {
                FlexibleView(
                    data: data,
                    spacing: viewModel.spacingBetweenCategories) { item, onLayoutChange in
                    SingleCategoryView(
                        viewModel: viewModel,
                        model: item,
                        onLayoutChange: onLayoutChange)
                }
            }
        }
        .padding(.vertical, 10)
    }
}

private extension CategoryGroup {
    /// The button for the `Category Title`
    func titleButton(title: String) -> some View {
        Button {
            withAnimation {
                isExpanded.toggle()
            }
        } label: {
            HStack {
                Text(title)
                    .font(.custom("SF-Pro-Text-Bold", size: 20))
                    .foregroundStyle(Color.black)
                    .padding(.trailing, 10)
                
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .animation(.easeInOut(duration: 0.25), value: isExpanded)
                
                Spacer()
            }
        }
    }
}
