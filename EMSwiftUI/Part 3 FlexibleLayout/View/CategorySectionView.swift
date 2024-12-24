//
//  CategorySectionView.swift
//  EMSwiftUI
//
//  Created by Максим Шишлов on 24.12.2024.
//

import SwiftUI

struct CategorySectionView: View {
    let section: FilterSection
    let onTagTap: (FilterTag) -> Void
    let toggleSection: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            categoryTitleView
            
            if section.isExpanded {
                TagCollectionView(data: section.tags, spacing: 10, alignment: .leading) { tag in
                    FilterTagView(tag: tag)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                onTagTap(tag)
                            }
                        }
                }
            }
        }
    }
}

extension CategorySectionView {
    private var categoryTitleView: some View {
        Button {
            withAnimation(.snappy) {
                toggleSection()
            }
        } label: {
            HStack {
                Text(section.title)
                    .font(.custom(FontFamily.SFProText.regular, size: 20))
                Image(systemName: section.isExpanded ? "chevron.up" : "chevron.down")
            }
            .foregroundStyle(.blackBase)
            .hSpacing(.leading)
        }
    }
}

