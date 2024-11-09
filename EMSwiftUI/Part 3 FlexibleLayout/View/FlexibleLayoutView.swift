//
//  FlexibleLayoutView.swift
//  EMSwiftUI
//
//  Created by Aleksandr Moskovtsev on 27.10.2024.
//

import SwiftUI

struct FlexibleLayoutView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    
    var availableWidth: CGFloat {
        UIScreen.main.bounds.width - 16
    }
    let spacing: CGFloat = 8
    let data: Data
    let content: (Data.Element) -> Content
    
    @State private var elementsSizes: [Data.Element: CGSize] = [:]
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSizes[element] = size
                            }
                    }
                }
            }
        }
    }
    
    private func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in data {
            let elementSize = elementsSizes[element, default: CGSize(width: Int(availableWidth), height: 1)]
            
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            
            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }
        
        return rows
    }
}
