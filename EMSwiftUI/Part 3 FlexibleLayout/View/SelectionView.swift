//
//  SelectionView.swift
//  EMSwiftUI
//
//  Created by Aleksandr Moskovtsev on 27.10.2024.
//

import SwiftUI

// MARK: - SelectionView
struct SelectionView: View {
    
    @ObservedObject var viewModel: FilterViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Selection")
                    .font(.custom(FontFamily.SFPro.bold, size: 20))
                    .foregroundStyle(.blackBase)
                    .padding(.leading)
                
                Spacer()
            }
            
            HStack {
                FlexibleLayoutView(data: viewModel.activeFilters) { tag in
                    TagButton(tag: tag, isOnSelectionView: true, viewModel: viewModel)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            SelectionButtonsView(viewModel: viewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = FilterViewModel(activeFilters: ["Test Filter", "Another Test Filter"])
    SelectionView(viewModel: viewModel)
}

private extension SelectionView {
    
    // MARK: - SelectionButtonsView
    struct SelectionButtonsView: View {
        
        @ObservedObject var viewModel: FilterViewModel
        
        var body: some View {
            VStack(spacing: 0) {
                Button {
                    viewModel.applyFilters()
                } label : {
                    Text("Apply")
                        .frame(maxWidth: 550, maxHeight: 44)
                        .font(.custom(FontFamily.SFPro.bold, size: 16))
                        .foregroundStyle(.whiteText)
                        .background(.orangeBase)
                        .cornerRadius(8)
                }
                
                Button {
                    viewModel.resetFilters()
                } label : {
                    Text("Reset")
                        .frame(maxWidth: 550, maxHeight: 44)
                        .font(.custom(FontFamily.SFPro.medium, size: 16))
                        .foregroundStyle(.blackBase)
                        .background(.white)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
