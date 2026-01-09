import SwiftUI

struct AllFiltersView<VM: FilterScreenViewModel>: View {
    @ObservedObject var viewModel: VM
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.allFilterTitles, id: \.self) { filterType in
                    filterSection(for: filterType)
                }
            } .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private func filterSection(for type: FilterTypes) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.toggleSection(type)
                }
            } label: {
                HStack(spacing: 8) {
                    Text(type.displayName)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.black)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(viewModel.expandedSections.contains(type) ? 180 : 0))
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            
            // Раскрытый контент с FlexibleLayout
            if viewModel.expandedSections.contains(type),
               let filters = viewModel.allAvailableFilters[type] {
                FlexibleLayout(
                    items: filters,
                    spacing: 12
                ) { filter in
                    FilterTagView(
                        title: filter,
                        isSelected: viewModel.isFilterSelected(filter),
                        showIcon: false
                    ) {
                        viewModel.toggleFilter(filter)
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding(.vertical, 12)
    }
}
