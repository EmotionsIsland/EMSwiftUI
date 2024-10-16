//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @StateObject private var viewModel = FilterViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                    SelectionView(
                        selectedTags: $viewModel.selectedTags,
                        toggleTag: viewModel.toggleTagSelected
                    )
                    
                    VStack {
                        applyButton
                        resetButton
                    }
                    
                    Divider()
                    
                    ForEach(viewModel.filterCategories, id: \.title) { category in
                        FilterCategoryView(
                            selectedTags: $viewModel.selectedTags,
                            title: category.title,
                            tags: category.tags,
                            toggleTag: viewModel.toggleTagSelected
                        )
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Filters")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        navigationButton
                    }
                }
        }
    }
}

extension FilterView {
    var applyButton: some View {
        Button(action: {
            //
        }) {
            Text("Apply")
                .font(.custom(FontFamily.SFPro.regular, size: 16))
                .frame(maxWidth: .infinity)
                .padding()
                .background(.orangeBase)
                .foregroundColor(.whiteText)
                .cornerRadius(8)
        }
    }
    
    var resetButton: some View {
        Button(action: {
            viewModel.resetTags()
        }) {
            Text("Reset")
                .font(.custom(FontFamily.SFPro.regular, size: 16))
                .foregroundColor(.blackBase)
                .padding()
                .frame(maxWidth: .infinity)
        }
    }
    
    var navigationButton: some View {
        Button(action: {
            //
        }) {
            Image(systemName: "xmark")
                .frame(width: 30, height: 30)
                .foregroundColor(.blackBase)
        }
    }
}
