//
//  FlexibleGridView.swift
//  EMSwiftUI
//
//  Created by Halil Yavuz on 17.12.2024.
//

import SwiftUI

struct FlexibleGridView<Content: View>: View {
    let items: [SectionTag]
    let content: (SectionTag) -> Content
    
    let columns = [
        GridItem(.adaptive(minimum: 140), spacing: 0),
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading ,spacing: 8) {
            ForEach(items) { item in
                content(item)
                    .lineLimit(1)
                
            }
            .padding(.horizontal, 16)
        }
    }
}

