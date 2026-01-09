//
//  AllFiltersView 3.swift
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
    
    // 3 РАВНЫЕ колонки
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
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
            
            // Раскрытый контент
            if viewModel.expandedSections.contains(type),
               let filters = viewModel.allAvailableFilters[type] {
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(filters, id: \.self) { filter in
                        Button {
                            viewModel.toggleFilter(filter)
                        } label: {
                            Text(filter)
                                .font(.system(size: 16, weight: .medium))
                                .lineLimit(1)
                                .frame(maxWidth: .infinity)  // ← КЛЮЧ: растянуть
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .background(
                                    viewModel.isFilterSelected(filter) 
                                        ? Color.orangeBase 
                                        : Color.grayBase
                                )
                                .foregroundColor(
                                    viewModel.isFilterSelected(filter) 
                                        ? .white 
                                        : .black
                                )
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding(.vertical, 12)
    }
}