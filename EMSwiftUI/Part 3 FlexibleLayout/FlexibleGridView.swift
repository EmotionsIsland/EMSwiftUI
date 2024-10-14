//
//  FlexibleGridView.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 13.10.2024.
//

import SwiftUI

struct FlexibleGridView: View {
    @Binding var selectedTags: [String]
    
    let items: [String]
    var isSelectable: Bool = true
    
    var toggleTag: (String) -> Void
    
    let columns = [GridItem(.adaptive(minimum: 100, maximum: .infinity), spacing: 8)]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
            ForEach(items, id: \.self) { item in
                Button(action: {
                    if isSelectable {
                        toggleTag(item)
                    }
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                            .frame(width: 10, height: 10)
                        Text(item)
                            .lineLimit(1)
                    }
                    .padding(13)
                    .background(selectedTags.contains(item) ? .orangeBase : .grayBase)
                    .foregroundColor(selectedTags.contains(item) ? .whiteText : .blackBase)
                    .cornerRadius(8)
                }
            }
        }
    }
}
