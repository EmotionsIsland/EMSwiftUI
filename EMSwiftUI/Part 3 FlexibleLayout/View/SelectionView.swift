//
//  SelectionView.swift
//  EMSwiftUI
//
//  Created by Александра Сергеева on 22.10.2024.
//

import SwiftUI

struct SelectionView: View {
    var selectedTags: [String]
    
    @State private var availableWidth: CGFloat = 0
    @State private var tagSizes: [String: CGSize] = [:]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Selection")
                .font(.custom(FontFamily.SFPro.bold, size: 20))
            
            contentView
        }
        .frame(maxWidth: 358, alignment: .leading)
        .padding(.vertical)
        .readSize { size in
            availableWidth = size.width
        }
    }
}

private extension SelectionView {
    @ViewBuilder
    var contentView: some View {
        if selectedTags.isEmpty {
            Text("No filters selected")
                .foregroundColor(.gray)
                .font(.custom(FontFamily.SFPro.regular, size: 16))
        } else {
            FlexibleView(data: selectedTags) { tag in
                createTagView(with: tag)
                    .readSize { size in
                        tagSizes[tag] = size
                    }
            }
        }
    }
    
    func createTagView(with text: String) -> some View {
        var tagView: some View {
            HStack(spacing: 2) {
                Image(systemName: "plus")
                    .frame(width: 20, height: 20)
                
                Text(text)
                    .font(.custom(FontFamily.SFPro.regular, size: 16))
            }
            .frame(maxWidth: 150, maxHeight: 36, alignment: .leading)
            .padding(8)
            .background(.orangeBase)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        return tagView
    }
}
