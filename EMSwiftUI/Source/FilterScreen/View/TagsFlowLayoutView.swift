//
//  TagsFlowLayoutView.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/17/25.
//

import SwiftUI

struct TagsFlowLayoutView: View {
    let tags: [SingleTagModel]
    let selectedTagsIDs: Set<String>?
    let spacing: CGFloat = 8
    let horizontalPadding: CGFloat = 16
    let actionHandler: (SingleTagModel) -> Void

    @State private var totalHeight = CGFloat.zero

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            GeometryReader { geometry in
                generateRows(in: geometry.size.width)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateRows(in avaliableWidth: CGFloat) -> some View {
        var width = CGFloat.zero
        var rows = [[SingleTagModel]]()

        for tag in tags {
            if rows.isEmpty {
                rows.append([])
            }

            let tagWidth = tag.title.width(withFont: UIFont(name: "SFPro-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)) + 32
            if width + tagWidth + spacing > avaliableWidth - horizontalPadding * 2 {
                rows.append([tag])
                width = tagWidth
            } else {
                rows[rows.count - 1].append(tag)
                width += tagWidth + spacing
            }
        }

        return VStack(alignment: .leading, spacing: spacing) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row) { tag in
                        let isSelected = selectedTagsIDs?.contains(tag.id) ?? true
                        DistinctTagView(title: tag.title,
                                        isSelected: isSelected) {
                            actionHandler(tag)
                        }
                    }
                }
            }
        }
        .background(viewHeightReader())
    }

    private func viewHeightReader() -> some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewHeightKey.self, value: geometry.size.height)
        }
        .onPreferenceChange(ViewHeightKey.self) { height in
            self.totalHeight = height
        }
    }

    private struct ViewHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
}
