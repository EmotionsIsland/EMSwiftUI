//
//  GridView.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 12.03.2025.
//

import SwiftUI

struct GridView: View {
    @State private var tagsSize: [String: CGSize] = [:]
    @ObservedObject var tagModel: TagModel
    
    var tags: [String]
    
    let spacing: CGFloat = 8
    let availableWidthSpace: CGFloat
    let buttonsMode: ButtonMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(computeRows(), id: \.self) { rowTags in
                HStack(spacing: 8) {
                    ForEach(rowTags, id: \.self) { tag in
                        TagButton(
                            tagModel: tagModel,
                            tag: tag,
                            buttonMode: buttonsMode
                        )
                        .readViewSize { size in
                            tagsSize[tag] = size
                        }
                    }
                }
            }
        }
    }
    
    func computeRows() -> [[String]] {
        var rows: [[String]] = [[]]
        var currentRow = 0
        var remainingWidth: CGFloat = availableWidthSpace
        
        for tag in tags {
            let elementSize = tagsSize[tag, default: CGSize(width: availableWidthSpace, height: 1)]
            
            if remainingWidth - elementSize.width >= 0 {
                rows[currentRow].append(tag)
            } else {
                currentRow += 1
                rows.append([tag])
                remainingWidth = availableWidthSpace
            }
            
            remainingWidth -= (elementSize.width + spacing)
        }
        
        return rows
    }
}

#Preview {
    GridView(tagModel: TagModel(), tags: ["random word really long", "second word", "third", "fourth word"], availableWidthSpace: 300, buttonsMode: .orange)
}
