//
//  LayoutView.swift
//  EMSwiftUI
//
//  Created by Evgenii Mikhailov on 14.03.2025.
//

import Foundation
import SwiftUI

struct WrappingStack<Items: RandomAccessCollection, Content: View>: View where Items.Element: Identifiable {
    
    private let items: Items
    private let spacing: CGFloat
    private let singleItemHeight: CGFloat
    private let content: (Items.Element) -> Content
    @State private var totalHeight: CGFloat = .zero
    
    init(items: Items, spacing: CGFloat, singleItemHeight: CGFloat, @ViewBuilder content: @escaping (Items.Element) -> Content) {
        self.items = items
        self.spacing = spacing
        self.singleItemHeight = singleItemHeight
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geometry in
                generateContent(in: geometry)
                    .background {
                        GeometryReader { geo in
                            Color.clear.preference(key: HeightPreferenceKey.self, value: geo.size.height)
                        }
                    }
            }
        }
        .onPreferenceChange(HeightPreferenceKey.self) { height in
            totalHeight = height
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(items) { item in
                content(item)
                    .alignmentGuide(.leading, computeValue: { dimension in
                            if abs(width - dimension.width) > geometry.size.width {
                                width = 0
                                height -= dimension.height + spacing
                            }
                            
                            let result = width
                            if item.id == items.last?.id {
                                width = 0
                            } else {
                                width -= dimension.width + spacing
                            }
                            return result
                        })
                    .alignmentGuide(.top, computeValue: { _ in
                            let result = height
                            if item.id == items.last?.id {
                                height = 0
                            }
                            return result
                        })
            }
        }
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
