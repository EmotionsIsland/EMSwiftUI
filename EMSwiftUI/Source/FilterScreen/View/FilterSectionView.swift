//
//  SectionView.swift
//  EMSwiftUI
//
//  Created by Глеб Поляков on 06.07.2025.
//

import SwiftUI

struct FilterSectionView: View {
    let tags: [TagPresentationModel]
    let spacing: CGFloat = 8
    let horizontalPadding: CGFloat = 16
    
    @State private var totalHeight = CGFloat.zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            GeometryReader { geometry in
                self.generateRows(in: geometry.size.width)
            }
        }
        .frame(height: totalHeight)
    }
    
    func generateRows(in avaliableWidth: CGFloat) -> some View {
        var width = CGFloat.zero
        var rows = [[TagPresentationModel]]()
        
        for tag in tags {
            let tagWidth = tag.title.width(withFont: .SFPro.bodyNormal)
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
                        FilterSingleGridView(tagTitile: tag.title)
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

#Preview {
    FilterSectionView(
        tags: [TagPresentationModel(id: "", title: "Any Demographic", group: "")])
}
