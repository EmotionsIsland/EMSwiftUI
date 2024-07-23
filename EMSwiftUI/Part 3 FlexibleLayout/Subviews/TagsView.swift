//
//  TagView.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 14.07.2024.
//

import SwiftUI

struct TagsView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    
    @State private var elementSize: [Data.Element : CGSize] = [:]
    @State private var availavleWidth: CGFloat = .zero

    let columns: [GridItem]
    let rows: [GridItem]
    let data: Data
    let content: (Data.Element) -> Content
    let spacing = 8.0
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Color.clear.frame(height: 1)
                .getSize { size in
                    availavleWidth = size.width
                }
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: spacing) {
                ForEach(computeRows(), id: \.self) { computedRow in
                    LazyHGrid(rows: rows) {
                        ForEach(computedRow, id: \.self) { item in
                            content(item)
                                .fixedSize()
                                .getSize { size in
                                    elementSize[item] = size
                                }
                            
                        }
                    }
                }
            }
            
        }
    }
    
    public init(data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
        
        rows = [GridItem(.flexible(), spacing: spacing, alignment: .leading)]
        columns = [GridItem(.flexible(), spacing: spacing, alignment: .leading)]
    }
    
}

//MARK: - Extension with private methods

private extension TagsView {
    
    private func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availavleWidth

        for element in data {
          let elementSize = elementSize[element, default: CGSize(width: availavleWidth, height: 1)]

          if remainingWidth - (elementSize.width + spacing) >= 0 {
            rows[currentRow].append(element)
          } else {
            // start a new row
            currentRow = currentRow + 1
            rows.append([element])
            remainingWidth = availavleWidth
          }

          remainingWidth = remainingWidth - (elementSize.width + spacing)
        }

        return rows
      }
    
}

//MARK: - Extension with private subobjects

private extension TagsView {
    
    struct ItemGroup: Hashable {
        var id = UUID()
        
        let item: [TagsViewItem]
    }
    
}
