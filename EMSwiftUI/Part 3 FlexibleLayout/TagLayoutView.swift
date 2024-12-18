//
//  TagLayoutView.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 17.12.2024.
//
import SwiftUI

struct TagLayoutView: View {
    @State private var allHeight: CGFloat = .zero
    @Binding var selectedTags: [SelectedTag]
    var action: (SelectedTag) -> ()
    
    var body: some View {
        if !selectedTags.isEmpty {
            VStack {
                GeometryReader { geometry in
                    generateContent(in: geometry)
                }
            }
            .frame(height: allHeight)
        }
    }
}

private extension TagLayoutView {
    func generateContent(in geometry: GeometryProxy) -> some View {
        var rows: [[SelectedTag]] = [[]]
        var width = CGFloat.zero
        
        for tag in selectedTags {
            let itemWidth = tag.text.sizeOfString(usingFont: UIFont.systemFont(ofSize: 16)).width + 30
            if width + itemWidth > geometry.size.width {
                rows.append([tag])
                width = itemWidth
            } else {
                rows[rows.count - 1].append(tag)
                width += itemWidth + 10
            }
        }
        
        DispatchQueue.main.async {
            self.allHeight = CGFloat(rows.count) * 50
        }
        
        return VStack(alignment: .leading, spacing: 10) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack(spacing: 10) {
                    ForEach(rows[rowIndex].indices, id: \.self) { tagIndex in
                        let tag = rows[rowIndex][tagIndex]
                        TagView(tag: Binding(
                            get: { rows[rowIndex][tagIndex] },
                            set: { updatedTag in
                                rows[rowIndex][tagIndex] = updatedTag
                                if let globalIndex = selectedTags.firstIndex(where: { $0.id == tag.id }) {
                                    selectedTags[globalIndex] = updatedTag
                                }
                            }
                        )) { selectedTag in
                            action(selectedTag)
                        }
                    }
                }
            }
        }
    }
}
