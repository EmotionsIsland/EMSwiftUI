//
//  FlexibleContainerView.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 19.02.2026.
//

import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct FlexibleContainerView<Content: View>: View {
    let spacing: CGFloat
    let items: [Tag]
    @ViewBuilder let content: (Tag) -> Content
    
    @State private var totalHeight = CGFloat.zero

    var body: some View {
        VStack {
            GeometryReader { geometry in
                var width = CGFloat.zero
                var height = CGFloat.zero
                
                ZStack(alignment: .topLeading) {
                    ForEach(items) { item in
                        content(item)
                            .padding(.all, spacing / 2)
                            .alignmentGuide(.leading, computeValue: { value in
                                if abs(width - value.width) > geometry.size.width {
                                    width = 0
                                    height -= value.height
                                }
                                let result = width
                                if item.id == items.last?.id {
                                    width = 0
                                } else {
                                    width -= value.width
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
                .background(
                    GeometryReader { geometry in
                        Color.clear.preference(
                            key: HeightPreferenceKey.self,
                            value: geometry.size.height
                        )
                    }
                )
            }
        }
        .frame(height: totalHeight)
        .animation(.default, value: totalHeight)
        .onPreferenceChange(HeightPreferenceKey.self) { height in
            totalHeight = height
        }
    }
}
