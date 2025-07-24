//
//  FilterSectionView.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import SwiftUI

struct FilterSectionView: View {
    @State private var isExpanded = false
    let model: FilterSectionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 16) {
                    Text(model.category)
                        .font(Font.SFPro.regularLarge)
                        .foregroundStyle(Color.blackBase)
                    
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .foregroundColor(Color.blackBase)
                        .animation(.easeInOut, value: isExpanded)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 8)
            
            if isExpanded {
                FlowLayout(items: model.tags, spacing: 8) { tag in
                    let index = model.tags.firstIndex(where: { $0.id == tag.id }) ?? 0
                    let isSelected = model.isSelected[index]
                    
                    return FilterTagView(tag: tag,
                                         isSelected: isSelected,
                                         action: { tappedTag in
                        model.onTagSelect(tappedTag)
                    })
                }
                .padding(.vertical, 8)
            }
        }
        .cornerRadius(12)
    }
}
