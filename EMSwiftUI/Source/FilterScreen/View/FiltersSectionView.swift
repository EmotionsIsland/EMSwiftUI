import SwiftUI

struct FiltersSectionView<VM: FilterScreenViewModel>: View {
    @ObservedObject var viewModel: VM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selection")
                .font(.system(size: 20, weight: .bold))
            
            if !viewModel.selectedFilters.isEmpty {
                FlexibleLayout(
                    items: Array(viewModel.selectedFilters).sorted(),
                    spacing: 8
                ) { filter in
                    FilterTagView(
                        title: filter,
                        isSelected: true,
                        showIcon: true
                    ) {
                        viewModel.toggleFilter(filter)
                    }
                }
            }
            
            Button {
                print("Apply filters: \(viewModel.selectedFilters)")
            } label: {
                Text("Apply")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.orangeBase)
                    .cornerRadius(8)
            }
            
            Button {
                viewModel.resetFilters()
            } label: {
                Text("Reset")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
