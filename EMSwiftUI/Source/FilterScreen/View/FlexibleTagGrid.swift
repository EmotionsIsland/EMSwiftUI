//
//  FlexibleTagGrid.swift
//  EMSwiftUI
//
//  Created by Pavel Plyago on 24.07.2025.
//

import SwiftUI

struct FlexibleTagGrid: View {
    let tags: [TagDisplayItem]
    var onTap: ((TagDisplayItem) -> Void)?
    
    var body: some View {
        ScrollView {
            if tags.isEmpty {
                Text("Нет тегов для отображения")
                    .foregroundColor(.grayBase)
                    .padding()
            } else if #available(iOS 16.0, *) {
                FlowLayout(spacing: 8) {
                    tagViews
                }
            } else {
                LazyVGrid(columns: [GridItem(.flexible(minimum: 60), spacing: 8)], alignment: .leading, spacing: 8) {
                    tagViews
                }
            }
        }
    }
    
    // Настройка тегов
    @ViewBuilder
    private var tagViews: some View {
        ForEach(tags) { tag in
            Text(tag.isSelected ? "+ \(tag.name)" : tag.name)
                .font(Font.SFPro.bodyNormal)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(tag.isSelected ? Color.orangeBase : Color.grayBase)
                .foregroundColor(tag.isSelected ? .white : .black)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                    onTap?(tag)
                }
        }
    }
}
