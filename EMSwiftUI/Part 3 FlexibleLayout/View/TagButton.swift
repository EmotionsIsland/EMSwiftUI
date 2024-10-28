//
//  TagButton.swift
//  EMSwiftUI
//
//  Created by Aleksandr Moskovtsev on 28.10.2024.
//

import SwiftUI

// MARK: - TagButton
struct TagButton: View {
    
    var tag: String
    var isOnSelectionView: Bool = false
    
    @ObservedObject var viewModel: FilterViewModel
    
    var body: some View {
        Button {
            viewModel.toggleTag(tag)
        } label: {
            HStack(spacing: 4) {
                if !viewModel.activeFilters.contains(tag) {
                    Image(systemName: "plus")
                        .frame(width: 16, height: 16)
                }
                
                Text(tag)
                    .font(.custom(FontFamily.SFPro.regular, size: 16))
            }
            .padding(8)
            .frame(maxWidth: 300, minHeight: 36)
            .background(isOnSelectionView || !viewModel.activeFilters.contains(tag) ? .orangeBase : .grayBase)
            .foregroundStyle(isOnSelectionView || !viewModel.activeFilters.contains(tag) ? .whiteText : .blackBase)
            .cornerRadius(8)
        }
    }
}

// MARK: - Preview
#Preview {
    TagButton(
        tag: "Test Tag",
        viewModel: FilterViewModel(activeFilters: [])
    )
}
