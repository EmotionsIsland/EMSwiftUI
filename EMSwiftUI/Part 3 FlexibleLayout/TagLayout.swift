//
//  TagLayout.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 10.12.2024.
//


import SwiftUI

@available(iOS 16.0, *)
struct TagLayout: Layout {
    
    var alignment: Alignment = .center
    var spacing: CGFloat = 10
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? 0
        let rows = generateRows(maxWidth, proposal, subviews)
        var height: CGFloat = 0
        for (index, row) in rows.enumerated() {
            if index == (rows.count - 1) {
                height += row.maxHeight(proposal) + spacing
            } else {
                height += row.maxHeight(proposal) + spacing
            }
        }
        return .init(width: maxWidth, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        let maxWidth = bounds.width
        
        let rows = generateRows(maxWidth, proposal, subviews)
        
        for row in rows {
            
            origin.x = 16
            
            for view in row {
                let viewSize = view.sizeThatFits(proposal)
                view.place(at: origin, proposal: proposal)
                origin.x += (viewSize.width + spacing)
            }
            origin.y += (row.maxHeight(proposal) + spacing)
        }
    }
    
    @available(iOS 16.0, *)
    func generateRows(_ maxWidth: CGFloat, _ proposal: ProposedViewSize, _ subviews: Subviews) -> [[LayoutSubviews.Element]] {
        var row: [LayoutSubviews.Element] = []
        var rows: [[LayoutSubviews.Element]] = []
        
        var origin = CGRect.zero.origin
        
        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)
            
            if (origin.x + viewSize.width + spacing) > maxWidth {
                rows.append(row)
                row.removeAll()
                
                origin.x = 0
                row.append(view)
                
                origin.x += (viewSize.width + spacing)
            } else {
                
                row.append(view)
                
                origin.x += (viewSize.width + spacing)
            }
        }
        if !row.isEmpty {
            rows.append(row)
            row.removeAll()
        }
        return rows
    }
}


@available(iOS 16.0, *)
extension [LayoutSubviews.Element] {
    func maxHeight(_ proposal: ProposedViewSize) -> CGFloat {
        return self.compactMap { view in
            return view.sizeThatFits(proposal).height
        }.max() ?? 0
    }
}
