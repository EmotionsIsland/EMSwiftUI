import SwiftUI

struct FilterScreen<ViewModel: FilterScreenViewModel>: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationBar("Filter", leftBarItems: {
                Button {
                    print("cancel")
                } label: {
                    buttonImage(icon: "xmark")
                }
            })
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    header
                    
                    TagsView(data: viewModel.selectedItems) { element in
                        TagsViewItem(title: element.name, isSelected: element.isSelected) {
                            withAnimation(.smooth) {
                                viewModel.selectItem(element)
                            }
                        }
                    }
                    
                    buttonSection
                }
                .padding(.horizontal)
                
                VStack(spacing: 24) {
                    ForEach(FilterCategory.allCases, id: \.self) { categoty in
                        DropDownView(
                            category: categoty,
                            items: viewModel.getItems(for: categoty),
                            onSelectAction: viewModel.selectItem
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

private extension FilterScreen {
    var buttonSection: some View {
        VStack(alignment: .center, spacing: 8) {
            Button {
                withAnimation { viewModel.applySelection() }
            } label: {
                Text("Apply")
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.whiteText)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.orangeBase)
                    )
            }
            Button {
                withAnimation { viewModel.resetSelection()}
            } label: {
                Text("Reset")
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.blackBase)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 0.5)
                            .foregroundStyle(.grayBase).opacity(0.5)
                    )
            }
        }
    }
    
    var header: some View {
        Text("Selection")
            .font(Font.SFPro.headline3)
            .foregroundStyle(.blackBase)
    }
    
    func buttonImage(icon: String) -> some View {
        Image(systemName: icon)
            .resizable()
            .frame(width: 15, height: 15)
            .padding(20)
            .background {
                Rectangle().fill(.clear)
                    .frame(width: 30, height: 30)
            }
    }
}

#Preview {
    FilterScreenBuilder.build().tint(.orangeBase)
}
