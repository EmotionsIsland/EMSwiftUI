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
                    ForEach(viewModel.category, id: \.self) { category in
                        Group {
                            if category == "Selection" {
                                FilterSelectionView(model: viewModel.filterSelectionModel)
                            } else {
                                FilterSectionView(model: viewModel.filterSectionModel(at: category))
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
