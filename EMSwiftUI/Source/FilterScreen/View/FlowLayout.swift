//
//  FlowLayout.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    @available(iOS 16.0, *)
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var totalHeight: CGFloat = 0
        var totalWidth: CGFloat = 0
        
        var lineWidth: CGFloat = 0
        var lineHeight: CGFloat = 0
        
        for size in sizes {
            let isFirstInLine = (lineWidth == 0)
            let additionalSpacing = isFirstInLine ? 0 : spacing
            
            if lineWidth + additionalSpacing + size.width > (proposal.width ?? 0) {
                // Переход на новую строку
                totalHeight += lineHeight
                lineWidth = size.width
                lineHeight = size.height
            } else {
                lineWidth += additionalSpacing + size.width
                lineHeight = max(lineHeight, size.height)
            }
            totalWidth = max(totalWidth, lineWidth)
        }
        
        totalHeight += lineHeight
        
        return .init(width: totalWidth, height: totalHeight)
    }
    
    @available(iOS 16.0, *)
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0
        
        for index in subviews.indices {
            let size = sizes[index]
            
            let isFirstInLine = (lineX == bounds.minX)
            let additionalSpacing = isFirstInLine ? 0 : spacing
            
            if lineX + additionalSpacing + size.width > (proposal.width ?? 0) {
                // Переход на новую строку
                lineY += lineHeight
                lineHeight = 0
                lineX = bounds.minX
            }
            
            let isFirstInNewLine = (lineX == bounds.minX)
            let currentSpacing = isFirstInNewLine ? 0 : spacing
            
            let placeX = lineX + currentSpacing
            
            subviews[index].place(
                at: .init(
                    x: placeX + size.width / 2,
                    y: lineY + size.height / 2
                ),
                anchor: .center,
                proposal: ProposedViewSize(size)
            )
            
            lineHeight = max(lineHeight, size.height)
            lineX = placeX + size.width
        }
    }
}
