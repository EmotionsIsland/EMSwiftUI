//
//  AllFiltersView 2.swift
//  EMSwiftUI
//
//  Created by Home on 09.01.2026.
//


//
//  AllFiltersView.swift
//  EMSwiftUI
//

import SwiftUI

struct AllFiltersView<VM: FilterScreenViewModel>: View {
    @ObservedObject var viewModel: VM
    
    // Adaptive с ПРАВИЛЬНЫМИ параметрами
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.allFilterTitles, id: \.self) { filterType in
                    filterSection(for: filterType)
                    
                    if filterType != viewModel.allFilterTitles.last {
                        Divider()
                            .padding(.vertical, 8)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private func filterSection(for type: FilterTypes) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header с chevron
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.toggleSection(type)
                }
            } label: {
                HStack(spacing: 8) {
                    Text(type.displayName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(viewModel.expandedSections.contains(type) ? 180 : 0))
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            
            // Раскрытый контент с LazyVGrid
            if viewModel.expandedSections.contains(type),
               let filters = viewModel.allAvailableFilters[type] {
                LazyVGrid(
                    columns: columns,
                    alignment: .leading,
                    spacing: 12  // ← вертикальный spacing
                ) {
                    ForEach(filters, id: \.self) { filter in
                        FilterTagView(
                            title: filter,
                            isSelected: viewModel.isFilterSelected(filter),
                            showIcon: false
                        ) {
                            viewModel.toggleFilter(filter)
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding(.vertical, 12)
    }
}
