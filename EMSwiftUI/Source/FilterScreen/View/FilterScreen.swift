//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct FilterScreen<VM: FilterViewModel>: View {
    @StateObject private var viewModel: VM
    @Binding var tabSelect: TabSelection
    
    init(viewModel: VM, tabSelected: Binding<TabSelection>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._tabSelect = tabSelected
    }
    
    let columns = [
        GridItem(.flexible(minimum: 80))
    ]
    
    var body: some View {
        VStack {
            FilterScreenTitleView(
                title: viewModel.navigationTitle,
                dismiss: {
                    tabSelect = .main
                })
                .padding(.bottom, 32)
            ScrollView {
                LazyVGrid(columns: columns,
                          alignment: .leading) {
                    ForEach(viewModel.category.indices, id: \.self) { index in
                        if index == 0 {
                            let titleSection = viewModel.category[index]
                            let selectedTags = viewModel.tagsSelected
                            
                            FilterSelectionView(
                                selectionTitle: titleSection,
                                tagsSelected: selectedTags,
                                isSelectedTag: { tag in
                                    viewModel.changeStateTag(for: tag)
                                }, resetAction: {
                                    viewModel.tagsSelected = []
                                })
                                .padding(.horizontal, 16)
                        } else {
                            let tags = viewModel.filterCategory(viewModel.category[index])
                            let category = viewModel.category[index]
                            let isSelected = viewModel.checkIsSelected(tags)
                            
                            FilterSectionView(
                                category: category,
                                tags: tags,
                                isSelected: isSelected, isSelectedTag: { tag in
                                    viewModel.changeStateTag(for: tag)
                                })
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.getTags()
        }
    }
}

@available(iOS 16.0, *)
#Preview {
    FilterScreenBuilder.build(tabSelected: .constant(.filter))
}
