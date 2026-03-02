//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HeaderView()
            
            ScrollView {
                FilterSelectionSectionView(
                    selectedTags: viewModel.getSelectedTagsFormatted(),
                    onTagTap: { id in viewModel.toggleTag(id) },
                    resetAction: { viewModel.reset() }
                )
                
                VStack(spacing: 24) {
                    ForEach(FilterSectionType.allCases, id: \.self) { section in
                        let sectionTags = viewModel.getTags(for: section)
                        
                        FilterSectionContainerView(title: section.rawValue) {
                            FlexibleContainerView(spacing: 8, items: sectionTags) { tag in
                                TagView(
                                    title: tag.attributes.name.en ?? "",
                                    isSelected: viewModel.selectedTagIds.contains(tag.id),
                                    action: { viewModel.toggleTag(tag.id, for: section) }
                                )
                            }
                        }
                    }
                }
                .padding(.top, 16)
            }
        }
    }
}
