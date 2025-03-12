//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @StateObject var tagModel: TagModel = TagModel()
    @State var availableWidthSpace: CGFloat = 0
    
    let spacing: CGFloat = 8
        
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
                .frame(height: 1)
                .readViewSize { size in
                    availableWidthSpace = size.width
                }
            ScrollView(.vertical) {
                SelectionView(
                    tagModel: tagModel,
                    availableWidthSpace: availableWidthSpace,
                    buttonsMode: .orange
                )
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(tagModel.tags.keys.sorted(), id: \.self) { key in
                        TagView(title: key) {
                            GridView(
                                tagModel: tagModel,
                                tags: tagModel.tags[key]!,
                                availableWidthSpace: availableWidthSpace,
                                buttonsMode: .white
                            )
                        }
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
