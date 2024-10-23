//
//  TagContainerView.swift
//  EMSwiftUI
//
//  Created by Алсу Хайруллина on 14.10.2024.
//

import SwiftUI

struct TagContainerView: View {
    
    @Binding var tags: [TagChipModel]
    
    let availableWidth: CGFloat
    let onSelectTag: (TagChipModel, Bool) -> Void
    
    var body: some View {
            let rows = calculateRows(for: tags, availableWidth: availableWidth)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.id) { tag in
                            if let index = tags.firstIndex(of: tag) {
                                TagChipView(tag: $tags[index]) { updatedTag, isSelected in
                                    onSelectTag(updatedTag, isSelected)
                                }
                            }
                        }
                    }
                }
            }
        }
}

private extension TagContainerView {
    
    func calculateRows(for items: [TagChipModel], availableWidth: CGFloat) -> [[TagChipModel]] {
        var rows: [[TagChipModel]] = []
        var currentRow: [TagChipModel] = []
        var currentWidth: CGFloat = 0
        
        for item in items {
            let chipWidth = calculateChipWidth(for: item.title)
            
            if currentWidth + chipWidth > availableWidth {
                rows.append(currentRow)
                currentRow = [item]
                currentWidth = chipWidth
            } else {
                currentRow.append(item)
                currentWidth += chipWidth + 10
            }
        }
        
        if !currentRow.isEmpty {
            rows.append(currentRow)
        }
        
        return rows
    }
    
    func calculateChipWidth(for text: String) -> CGFloat {
        let imageWidth: CGFloat = 20
        let imageSpacing: CGFloat = 4
        let padding: CGFloat = 16
        
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        
        let textWidth = (text as NSString).size(withAttributes: attributes).width
        
        return imageWidth + imageSpacing + textWidth + padding
    }
}
