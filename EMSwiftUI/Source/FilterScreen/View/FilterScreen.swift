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
            VStack {
                FilterListScreenHeader()
                
                SelectionCategoriesView(viewModel: viewModel)
                
                groupWithCategories()
                
            }
            .padding(.horizontal, 8)
        }
    }
}

private extension FilterScreen {
    func groupWithCategories() -> some View {
        Group {
            CategoryGroup(
                viewModel: viewModel,
                title: "Format",
                data: viewModel.filterByFormat())
            
            CategoryGroup(
                viewModel: viewModel,
                title: "Genre",
                data: viewModel.filterByGenre())
            
            CategoryGroup(
                viewModel: viewModel,
                title: "Theme",
                data: viewModel.filterByTheme())
        }
    }
}
