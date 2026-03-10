//
//  FlowLayout.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 10.03.2026.
//

import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        
        var xAxis: CGFloat = 0
        var yAxis: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            
            if xAxis + size.width > maxWidth {
                xAxis = 0
                yAxis += rowHeight + spacing
                rowHeight = 0
            }
            
            rowHeight = max(rowHeight, size.height)
            xAxis += size.width + spacing
        }
        
        return CGSize(width: maxWidth, height: yAxis + rowHeight)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        var xBounds = bounds.minX
        var yBounds = bounds.minY
        var rowHeight: CGFloat = 0
        
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            
            if xBounds + size.width > bounds.maxX {
                xBounds = bounds.minX
                yBounds += rowHeight + spacing
                rowHeight = 0
            }
            
            view.place(
                at: CGPoint(x: xBounds, y: yBounds),
                proposal: ProposedViewSize(size)
            )
            
            rowHeight = max(rowHeight, size.height)
            xBounds += size.width + spacing
        }
    }
}
