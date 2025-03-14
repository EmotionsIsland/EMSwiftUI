//
//  GridView.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 12.03.2025.
//

import SwiftUI

enum GridViewMode {
    case selection, topic
}

struct GridView: View {
    @State private var tagsSize: [String: CGSize] = [:]
    @ObservedObject var tagViewModel: TagViewModel
    
    let gridViewMode: GridViewMode
    let title: String
    let availableWidthSpace: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(computeRows(from: getRowsData()), id: \.self) { rowTags in
                HStack(spacing: 8) {
                    ForEach(rowTags, id: \.self) { tag in
                        TagButton(
                            tagViewModel: tagViewModel,
                            title: getTitle(by: tag),
                            tag: tag,
                            buttonMode: getButtonMode(by: tag)
                        )
                        .readViewSize { size in
                            tagsSize[tag] = size
                        }
                    }
                }
            }
        }
    }
}

private extension GridView {
    func getTitle(by tag: String) -> String {
        switch gridViewMode {
        case .selection:
            let title = tagViewModel.selectedTags.first(where: { $0.tag == tag })?.title ?? TagStruct.defaultTag.title
            return title
        case .topic:
            return title
        }
    }
    
    func getButtonMode(by tag: String) -> ButtonMode {
        switch gridViewMode {
        case .selection:
            return .selected
        case .topic:
            let isSelected = tagViewModel.tags[title]!.first(where: { $0.tag == tag} )?.isSelected ?? false
            return isSelected ? .selected : .unselected
        }
    }
    
    func getRowsData() -> [String] {
        var tags: [String] = []
        
        switch gridViewMode {
        case .selection:
            for tag in tagViewModel.selectedTags {
                tags.append(tag.tag)
            }
        case .topic:
            let topicTags = tagViewModel.tags[title]!
            for tag in topicTags {
                tags.append(tag.tag)
            }
        }
        
        return tags
    }
    
    func computeRows(from data: [String]) -> [[String]] {
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

#Preview {
    GridView(
        tagViewModel: TagViewModel(),
        gridViewMode: .topic,
        title: "Stars",
        availableWidthSpace: 300
    )
}
