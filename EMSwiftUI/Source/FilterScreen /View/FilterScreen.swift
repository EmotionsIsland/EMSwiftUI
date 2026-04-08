//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SelectionSectionView(selectedTags: viewModel.selectedTags,
                                     onTagTap: { id in viewModel.toggleTag(id: id)},
                                     onReset: { viewModel.reset()})
                
                Divider().background(Color.blackBase.opacity(0.3)).frame(height: 8)
                
                CategoriesSectionView(groupTags: viewModel.groupTags,
                                      selectedTagsIDs: viewModel.selectedTagsIDs,
                                      onTagTap: { id in viewModel.toggleTag(id: id)},
                                      sortedKeys: viewModel.sortedKeys)
            }
        }
        .task {
             viewModel.fetchTags()
        }
    }
}
