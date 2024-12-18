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
            ScrollView {
                VStack(spacing: 26) {
                    // Selection Section
                    VStack(alignment: .leading) {
                        selectionTitle
                        FlexibleGridView(items: viewModel.selectedTags) { tag in
                            TagView(tag: tag.name, isSelected: true)
                                .onTapGesture {
                                    if let section = viewModel.sections.first(where: { $0.tags.contains(where: { $0.id == tag.id }) }) {
                                        viewModel.toggleTagSelection(section: section, tag: tag)
                                    }
                                }
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    applyButton
                    resetButton
                    
                    // Sections with Tags
                    ForEach(viewModel.sections) { section in
                        ExpandableSectionView(
                            section: section,
                            toggleTagSelection: viewModel.toggleTagSelection,
                            selectedTags: $viewModel.selectedTags
                        )
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Filters")
                        .font(FontFamily.SFProText.bold.swiftUIFont(size: 24))
                    
                }
            }
            
        }
        
    }
    
}

//MARK: - UI

private extension FilterView {
    
    var selectionTitle: some View {
        Text("Selection")
            .font(FontFamily.SFProText.bold.swiftUIFont(size: 20))
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        
    }
    
    var applyButton: some View {
        Button {}
        label: {
            HStack {
                Spacer()
                Text("Apply")
                Spacer()
                
            }
        }
        
        .padding(.vertical, 12)
        .font(FontFamily.SFProText.regular.swiftUIFont(size: 16))
        .foregroundStyle(.white)
        .background(Asset.Colors.orangeBase.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 16)
        
    }
    
    var resetButton: some View {
        Button {
            viewModel.resetAllTags()
        } label: {
            Text("Reset")
        }
        .font(FontFamily.SFProText.regular.swiftUIFont(size: 16))
        
        .foregroundStyle(Asset.Colors.blackBase.swiftUIColor)
        
    }
}

#Preview {
    FilterView()
}
