//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @StateObject var viewModel = FilterViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    SelectionView(
                        selectedTags: $viewModel.selectedTags,
                        toggleTag: viewModel.toggleTagSelected
                    )
                    
                    VStack {
                        applyButton
                        resetButton
                    }
                    .padding(.bottom, 8)
                    
                    Divider()
                    
                    FilterCategoryView(
                        selectedTags: $viewModel.selectedTags,
                        title: "Content RatingTags",
                        tags: viewModel.сontentRatingTags,
                        toggleTag: viewModel.toggleTagSelected
                    )
                    
                    FilterCategoryView(
                        selectedTags: $viewModel.selectedTags,
                        title: "Publication Status",
                        tags: viewModel.publicationStatusTags, toggleTag: viewModel.toggleTagSelected
                    )
                    
                    FilterCategoryView(
                        selectedTags: $viewModel.selectedTags,
                        title: "Magazine Demographic",
                        tags: viewModel.magazineDemographicTags, toggleTag: viewModel.toggleTagSelected
                    )
                    
                    FilterCategoryView(
                        selectedTags: $viewModel.selectedTags,
                        title: "Format",
                        tags: viewModel.formatTags,
                        toggleTag: viewModel.toggleTagSelected
                    )
                    
                    FilterCategoryView(
                        selectedTags: $viewModel.selectedTags,
                        title: "Genre",
                        tags: viewModel.genreTags
                        , toggleTag: viewModel.toggleTagSelected
                    )
                    
                    FilterCategoryView(
                        selectedTags: $viewModel.selectedTags,
                        title: "theme",
                        tags: viewModel.themeTags,
                        toggleTag: viewModel.toggleTagSelected
                    )
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Filters")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) { navigationButton }
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
        }
        .frame(width: 358, height: 44)
        .background(.orangeBase)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
    
    var resetButton: some View {
        Button(action: {
            viewModel.resetTags()
        }) {
            Text("Reset")
                .font(.custom(FontFamily.SFPro.regular, size: 16))
                .foregroundColor(.blackBase)
        }
    }
    
    var navigationText: some View {
        Text("Filters")
            .font(.custom(FontFamily.SFPro.bold, size: 20))
            .foregroundStyle(.blackBase)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .offset(x: 23)
    }
    
    var navigationButton: some View {
        Button(action: {
            //
        }) {
            Image(systemName: "xmark")
                .frame(width: 30, height: 30)
                .foregroundStyle(.blackBase)
        }
    }
}

#Preview {
    FilterView()
}
