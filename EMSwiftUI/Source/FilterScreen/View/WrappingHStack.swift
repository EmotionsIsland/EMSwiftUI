//
//  WrappingHStack.swift
//  EMSwiftUI
//

import SwiftUI

struct WrappingHStack<Item: Hashable, Content: View>: View {
    let items: [Item]
    let spacing: CGFloat
    let content: (Item) -> Content
    
    init(
        items: [Item],
        spacing: CGFloat = 12,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }
    
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        return ZStack(alignment: .topLeading) {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                
                content(item)
                    .alignmentGuide(.leading) { dimension in
                        if abs(width - dimension.width) > geometry.size.width {
                            width = 0
                            height -= dimension.height + spacing
                        }
                        
                        let result = width
                        
                        if index == items.count - 1 {
                            width = 0
                        } else {
                            width -= dimension.width + spacing
                        }
                        
                        return result
                    }
                    .alignmentGuide(.top) { dimension in
                        let result = height
                        
                        if index == items.count - 1 {
                            height = 0
                        }
                        
                        return result
                    }
            }
        }
    }
}
