//
//  GridView.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 12.03.2025.
//

import SwiftUI

struct GridView: View {
    @State private var tagsSize: [String: CGSize] = [:]
    @ObservedObject var tagViewModel: TagViewModel
    
    let gridViewMode: GridViewMode
    let title: String
    let availableWidthSpace: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(tagViewModel.computeRows(
                by: title,
                for: gridViewMode, tagsSize, availableWidthSpace), id: \.self)
            { rowTags in
                HStack(spacing: 8) {
                    ForEach(rowTags, id: \.self) { tag in
                        TagButton(
                            tagViewModel: tagViewModel,
                            title: tagViewModel.getTitle(
                                by: tag, title,
                                for: gridViewMode
                            ),
                            tag: tag,
                            buttonMode: tagViewModel.getButtonMode(
                                by: tag, title,
                                for: gridViewMode
                            )
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

#Preview {
    GridView(
        tagViewModel: TagViewModel(),
        gridViewMode: .topic,
        title: "Stars",
        availableWidthSpace: 300
    )
}
