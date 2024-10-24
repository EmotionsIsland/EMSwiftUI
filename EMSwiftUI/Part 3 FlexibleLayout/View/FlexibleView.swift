//
//  FlexibleView.swift
//  EMSwiftUI
//
//  Created by Александра Сергеева on 23.10.2024.
//

import SwiftUI

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    var data: Data
    let content: (Data.Element) -> Content
    
    @State private var availableWidth: CGFloat = 0
    @State private var elementSizes: [Data.Element: CGSize] = [:]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: 8) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementSizes[element] = size
                            }
                    }
                }
            }
        }
        .onAppear {
            availableWidth = (UIScreen.main.bounds.width - 16)
        }
    }
    
    private func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in data {
            let elementSize = elementSizes[element, default: CGSize(width: Int(availableWidth), height: 1)]
            
            if remainingWidth - (elementSize.width + 16) > 0 {
                rows[currentRow].append(element)
            } else {
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            
            remainingWidth -= (elementSize.width + 16)
        }
        
        return rows
    }
}

