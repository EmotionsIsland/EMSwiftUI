//
//  FlexibleLayout.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 30.03.2025.
//

import Foundation
import SwiftUI

struct FlexibleLayout<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View {
    let data: Data
    let id: KeyPath<Data.Element, ID>
    let spacing: CGFloat
    let content: (Data.Element) -> Content

    @State private var availableWidth: CGFloat = .zero
    @State private var elementWidths: [ID: CGFloat] = [:]

    private var rows: [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var remainingWidth = availableWidth

        for element in data {
            let elementWidth = ceil(elementWidths[element[keyPath: id], default: availableWidth])

            if remainingWidth - (elementWidth + spacing) <= 0 {
                remainingWidth = availableWidth - (elementWidth + spacing)
                rows.append([element])
            } else {
                remainingWidth -= (elementWidth + spacing)
                rows[rows.count - 1].append(element)
            }
        }

        return rows
    }

    init(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        spacing: CGFloat = 0,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack(spacing: spacing) {
                    ForEach(rows[rowIndex], id: id) { element in
                        content(element)
                            .fixedSize()
                            .size { elementWidths[element[keyPath: id]] = $0.width }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background {
            Color.clear
                .size { availableWidth = $0.width }
        }
    }
}

extension View {
    fileprivate func size(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

#Preview {
    ScrollView {
        FlexibleLayout(0..<1000, id: \.self, spacing: 3) { element in
            Text("\(element)")
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundStyle(.white)
                .background(.gray)
                .cornerRadius(10)
        }
        .padding()
    }
}
