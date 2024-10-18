//
//  FlowLayout.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 15.10.2024.
//

import SwiftUI

struct FlowLayout: View {
    @State private var totalHeight: CGFloat = .zero
    @Binding var selectedTags: [String]
    
    let items: [String]
    var isSelectable: Bool
    var toggleTag: (String) -> Void
    
    var body: some View {
        if !items.isEmpty {
            VStack {
                GeometryReader { geometry in
                    self.generateContent(in: geometry)
                }
            }
            .frame(height: totalHeight)
        }
    }
    
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var rows: [Array<String>] = [[]]
        
        for item in items {
            let itemWidth = item.sizeOfString(usingFont: .systemFont(ofSize: 16)).width + 30
            if width + itemWidth > geometry.size.width {
                rows.append([item])
                width = itemWidth
            } else {
                rows[rows.count - 1].append(item)
                width += itemWidth + 10
            }
        }
        
        DispatchQueue.main.async {
            self.totalHeight = CGFloat(rows.count) * 50
        }
        
        return VStack(alignment: .leading, spacing: 10) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { item in
                        TagButton(item: item, isSelected: selectedTags.contains(item)) {
                            if isSelectable {
                                toggleTag(item)
                            }
                        }
                    }
                }
            }
        }
    }
}
