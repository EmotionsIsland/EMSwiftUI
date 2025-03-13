//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @StateObject private var tagViewModel: TagViewModel = TagViewModel()
    @State private var availableWidthSpace: CGFloat = 0
        
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
                .frame(height: 1)
                .readViewSize { size in
                    availableWidthSpace = size.width
                }
            ScrollView(.vertical) {
                SelectionView(
                    tagViewModel: tagViewModel,
                    availableWidthSpace: availableWidthSpace
                )
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(tagViewModel.tags.keys.sorted(), id: \.self) { key in
                        TagView(title: key) {
                            GridView(
                                tagViewModel: tagViewModel,
                                gridViewMode: .topic,
                                title: key,
                                availableWidthSpace: availableWidthSpace
                            )
                        }
                        .drawingGroup()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    FilterView()
}
