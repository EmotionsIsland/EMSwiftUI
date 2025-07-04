//
//  FlowLayout.swift
//  EMSwiftUI
//
//  Created by Ruslan on 04.07.2025.
//

import SwiftUI

struct FlowLayout: Layout {
    @available(iOS 16.0, *)
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let subSizes = subviews.map { $0.sizeThatFits(proposal) }

        let proposedWidth = proposal.width ?? .infinity
        var maxRowWidth = CGFloat.zero
        var rowCount = CGFloat.zero
        var xCoordinate  = CGFloat.zero
        for subSize in subSizes {
            // This prevents empty rows if any subviews are wider than proposedWidth.
            let lineBreakAllowed = xCoordinate  > 0

            if lineBreakAllowed, xCoordinate  + subSize.width > proposedWidth {
                rowCount += 1
                xCoordinate  = 0
            }

            xCoordinate  += subSize.width
            maxRowWidth = max(maxRowWidth, xCoordinate)
        }

        if xCoordinate  > 0 {
            rowCount += 1
        }

        let rowHeight = subSizes.lazy.map { $0.height }.max() ?? 0
        return CGSize(
            width: proposal.width ?? maxRowWidth,
            height: rowCount * rowHeight
        )
    }
    
    @available(iOS 16.0, *)
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let subSizes = subviews.map { $0.sizeThatFits(proposal) }
        let rowHeight = subSizes.lazy.map { $0.height }.max() ?? 0
        let proposedWidth = proposal.width ?? .infinity

        var point = CGPoint.zero
        for (subview, subSize) in zip(subviews, subSizes) {
            // This prevents empty rows if any subviews are wider than proposedWidth.
            let lineBreakAllowed = point.x > 0

            if lineBreakAllowed, point.x + subSize.width > proposedWidth {
                point.x = 0
                point.y += rowHeight
            }

            subview.place(
                at: CGPoint(
                    x: bounds.origin.x + point.x,
                    y: bounds.origin.y + point.y + 0.5 * (rowHeight - subSize.height)
                ),
                proposal: proposal
            )

            point.x += subSize.width
        }
    }
}
