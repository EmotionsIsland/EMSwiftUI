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
    
    let columns = [
        GridItem(.flexible(minimum: 80))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            FilterScreenTitleView(
                title: viewModel.navigationTitle,
                dismiss: {
                    print("dismiss")
                })
            ScrollView {
                LazyVGrid(columns: columns,
                          alignment: .leading) {
                    ForEach(viewModel.category.indices, id: \.self) { index in
                        Group {
                            if index == 0, let model = viewModel.filterSelectionModel {
                                FilterSelectionView(model: model)
                            } else if let model = viewModel.filterSectionModel(at: index) {
                                FilterSectionView(model: model)
                            }
                        }
                        .padding(16)
                    }
                }
                .padding(.top)
            }
        }
        .task {
            await viewModel.getTags()
        }
    }
}

#Preview {
    FilterScreenBuilder.build()
}
