//
//  GridService.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 17.03.2025.
//

import SwiftUI

enum GridViewMode {
    case selection, topic
}

final class GridService {
    
    func getTitle(
        by tag: String, _ title: String,
        for gridViewMode: GridViewMode, _ selectedTags: [TagStruct]
    ) -> String {
        
        switch gridViewMode {
        case .selection:
            let title = selectedTags.first(where: { $0.tag == tag })?.title ?? TagStruct.defaultTag.title
            return title
        case .topic:
            return title
        }
    }
    
    func getButtonMode(
        by tag: String, _ title: String,
        for gridViewMode: GridViewMode, _ tagsData: [String : [TagStruct]]
    ) -> ButtonMode {
        
        switch gridViewMode {
        case .selection:
            return .selected
        case .topic:
            let isSelected = tagsData[title]!.first(where: { $0.tag == tag} )?.isSelected ?? false
            return isSelected ? .selected : .unselected
        }
    }
    
    func getRowsData(
        by title: String,
        for gridViewMode: GridViewMode, _ selectedTags: [TagStruct], _ tagsData: [String : [TagStruct]]
    ) -> [String] {
        
        var tags: [String] = []
        
        switch gridViewMode {
        case .selection:
            for tag in selectedTags {
                tags.append(tag.tag)
            }
        case .topic:
            let topicTags = tagsData[title]!
            for tag in topicTags {
                tags.append(tag.tag)
            }
        }
        
        return tags
    }
    
    func computeRows(
        from data: [String],
        for tagsSize: [String: CGSize], _ availableWidthSpace: CGFloat
    ) -> [[String]] {
        
        var rows: [[String]] = [[]]
        var currentRow = 0
        var remainingWidth: CGFloat = availableWidthSpace
        
        for tag in data {
            let elementSize = tagsSize[tag, default: CGSize(width: availableWidthSpace, height: 1)]
            
            if remainingWidth - elementSize.width >= 0 {
                rows[currentRow].append(tag)
            } else {
                currentRow += 1
                rows.append([tag])
                remainingWidth = availableWidthSpace
            }
            
            remainingWidth -= (elementSize.width)
        }
        
        return rows
    }
}
