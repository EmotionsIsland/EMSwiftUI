//
//  FilterSectionView.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct FilterSectionView: View {
    @State private var isExpanded = false
    var category: String
    var tags: [Tag]
    var isSelected: [Bool]
    var isSelectedTag: (Tag) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 16) {
                    Text(category)
                        .font(Font.SFPro.regularLarge)
                        .foregroundStyle(Color.init(cgColor: #colorLiteral(red: 0.2834452093, green: 0.2834451795, blue: 0.2834452093, alpha: 1)))
                        
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .foregroundColor(Color.init(cgColor: #colorLiteral(red: 0.2834452093, green: 0.2834451795, blue: 0.2834452093, alpha: 1)))
                        .animation(.easeInOut, value: isExpanded)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            
            if isExpanded {
                FlowLayout {
                    ForEach(tags.indices,
                            id: \.self) { index in
                        let tag = tags[index]
                        let isSelected = self.isSelected[index]
                        FilterTagView(tag: tag,
                                      isSelected: isSelected,
                                      action: { tag in
                            isSelectedTag(tag)
                        })
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .cornerRadius(12)
    }
}
