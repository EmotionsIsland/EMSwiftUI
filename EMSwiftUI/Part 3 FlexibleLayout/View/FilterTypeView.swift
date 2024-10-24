//
//  FilterTypeView.swift
//  EMSwiftUI
//
//  Created by Александра Сергеева on 22.10.2024.
//

import SwiftUI

struct FilterTypeView: View {
    var filter: FilterType
    var tags: [String]
    
    @EnvironmentObject var viewModel: FilterViewModel
    
    @State private var availableWidth: CGFloat = 0
    @State private var tagSizes: [String: CGSize] = [:]
    @State private var isExpanded: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                filterView
            }
            
            if isExpanded {
                FlexibleView(data: tags) { tag in
                    createTagButtonView(with: tag)
                }
            }
        }
        .padding(.vertical, 4)
        .foregroundColor(.black)
    }
}

private extension FilterTypeView {
    var filterView: some View {
        HStack {
            Text(filter.rawValue.capitalized)
                .font(.custom(FontFamily.SFPro.regular, size: 20))
            
            Spacer()
            
            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
        }
    }
    
    func createTagButtonView(with tag: String) -> some View {
        @ViewBuilder
        var contentView: some View {
            HStack(spacing: 2) {
                if viewModel.selectedTags.contains(tag) {
                    Image(systemName: "plus")
                        .frame(width: 20, height: 20)
                    
                    tagButtonView
                } else {
                    tagButtonView
                }
            }
            .padding(8)
            .frame(maxWidth: 150, minHeight: 36)
            .background(viewModel.selectedTags.contains(tag) ? Color.orangeBase : Color.grayBase.opacity(0.5))
            .foregroundColor(viewModel.selectedTags.contains(tag) ? Color.whiteText : Color.blackBase)
            .cornerRadius(8)
        }
        
        var tagButtonView: some View {
            Text(tag)
                .onTapGesture {
                    viewModel.removeOrAppendTag(tag)
                }
                .font(.custom(FontFamily.SFPro.regular, size: 16))
        }
        
        return contentView
    }
}

