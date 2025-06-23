//
import SwiftUI

struct SingleCategoryView<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    
    var isSelected: Bool {
        viewModel.isSelected(model)
    }
    
    let model: TagData
    let onLayoutChange: () -> Void
    
    init(viewModel: VM,
         model: TagData,
         onLayoutChange: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.model = model
        self.onLayoutChange = onLayoutChange
    }
    
    var body: some View {
        HStack {
            if isSelected {
                Text("+")
                    .font(.system(size: 24, weight: .light))
                    .foregroundStyle(Color.whiteText)
            }
            
            Text(model.attributes.name.en ?? "")
                .font(Font.custom("SF-Pro-Text-Black", size: 16))
                .foregroundStyle(isSelected ? Color.whiteText : Color.black)
        }
        .padding(EdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8))
        .frame(height: 36)
        .background(isSelected ? Color.orangeBase : Color.grayBase)
        .cornerRadius(8)
        .onTapGesture {
            if isSelected {
                viewModel.selectionCategories.removeAll { $0.id == model.id }
            } else {
                viewModel.selectionCategories.append(model)
            }
            onLayoutChange()
        }
    }
}
