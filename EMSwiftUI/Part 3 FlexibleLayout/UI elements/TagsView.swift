//
//  TagView.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 14.07.2024.
//

import SwiftUI

struct TagsView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    
    //MARK: - Private properties
    
    @State private var elementSize: [Data.Element : CGSize] = [:]
    @State private var availavleWidth: CGFloat = .zero

    private let columns: [GridItem]
    private let rows: [GridItem]
    private let data: Data
    private let content: (Data.Element) -> Content
    private let spacing = 8.0

    //MARK: - UI
    
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
    
    //MARK: - Initialaizers
    
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
