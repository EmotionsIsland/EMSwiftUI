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
        VStack(spacing: 32) {
            
            FilterNavigationView()
            
            VStack(spacing: 16) {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Selection")
                        .font(.custom(FontFamily.SFProText.bold, size: 20))
                        .foregroundStyle(.blackBase)
                    
                    if viewModel.selectedTags.isEmpty {
                        Text("There are no favorite tags here yet")
                    } else {
                        TagCollectionView(data: viewModel.selectedTags, spacing: 8, alignment: .leading) { tag in
                            FilterTagView(tag: tag)
                        }
                    }
                    
                    selectionButtonsView
                    
                    Divider()
                }
                .hSpacing(.leading)
            
                categoryFilterView
                
            }
            .padding(.horizontal, 16)
        }
    }
}

extension FilterView {
    
    private var categoryFilterView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 26) {
                ForEach(viewModel.sections) { section in
                    CategorySectionView(
                        section: section,
                        onTagTap: { tag in
                            viewModel.addTag(tag)
                        },
                        toggleSection: {
                            viewModel.toggleSection(section)
                        }
                    )
                }
            }
        }
    }
    
    private var selectionButtonsView: some View {
        VStack(spacing: 8) {
            Button {
                
            } label: {
                Text("Apply")
                    .padding(.vertical, 12)
                    .hSpacing()
                    .background(.orangeBase, in: RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.white)
                    .font(.custom(FontFamily.SFProText.medium, size: 16))
            }
            
            Button {
                withAnimation(.snappy) {
                    viewModel.clearSelection()
                }
            } label: {
                Text("Reset")
                    .foregroundStyle(.blackBase)
                    .font(.custom(FontFamily.SFProText.medium, size: 16))
            }
        }
    }
    
}
