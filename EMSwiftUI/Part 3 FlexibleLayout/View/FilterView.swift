//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = FilterViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 8) {
                    selectionTitle
                    selectedTags(width: geometry.size.width)
                    applyButton
                    resetButton
                    Divider()
                    categoriesView(width: geometry.size.width)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) { BackButton() }
        }
        .padding()
    }
}

private extension FilterView {
    
    var selectionTitle: some View {
        Text("Selection")
            .font(FontFamily.SFProText.semibold.swiftUIFont(size: 20))
    }
    
    @ViewBuilder func selectedTags(width: CGFloat) -> some View {
        VStack {
            switch viewModel.selectedTags.isEmpty {
            case true:
                Text("No selected Tags")
            case false:
                TagContainerView(
                    tags: $viewModel.selectedTags,
                    availableWidth: width
                ) { tag, isSelected in
                    if isSelected {
                        viewModel.addTagToSelected(tag)
                    } else {
                        viewModel.removeTagFromSelected(tag) 
                    }
                }
            }
        }
    }
    
    var applyButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Apply")
        }
        .font(FontFamily.SFProText.regular.swiftUIFont(size: 16))
        .frame(maxWidth: .infinity, maxHeight: 44)
        .foregroundStyle(.white)
        .background(.orangeBase)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    var resetButton: some View {
        Button {
            viewModel.resetSelectedTags()
        } label: {
            Text("Reset")
        }
        .font(FontFamily.SFProText.regular.swiftUIFont(size: 16))
        .frame(maxWidth: .infinity, maxHeight: 32)
        .foregroundStyle(.black)
        
    }
    
    func categoriesView(width: CGFloat) -> some View {
        let categories = [
            ("Genres", $viewModel.genresTags),
            ("Publication Status", $viewModel.statusTags),
            ("Format", $viewModel.formatTags)
        ]
        
        return ScrollView {
            ForEach(categories, id: \.0) { (title, tags) in
                DropDownTagsView(
                    title: title,
                    tags: tags,
                    availableWidth: width
                ) { tag, isSelected in
                    if isSelected {
                        viewModel.addTagToSelected(tag)
                    } else {
                        viewModel.removeTagFromSelected(tag)
                    }
                }
            }
        }
    }
    
}

#Preview {
    FilterView()
}
