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
        VStack {
            FilterListScreenHeader()
            
            SelectionCategoriesView(viewModel: viewModel)
            
            scrollWithCategories()
        }
        .padding(EdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8))
    }
}

private extension FilterScreen {
    func scrollWithCategories() -> some View {
        return ScrollView {
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
        .padding(.bottom, 40)
    }
}
