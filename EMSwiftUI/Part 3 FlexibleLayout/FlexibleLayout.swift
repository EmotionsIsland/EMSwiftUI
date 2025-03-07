//
//  FlexibleGrid.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 07.03.2025.
//

import SwiftUI

// структура отображает грид с динамическим размером
struct FlexibleLayout<Content: View>: View {
    let array: [String]
    let content: (String) -> Content
    @State private var screenWidth: CGFloat = 0
    @State private var gridHeight: CGFloat = 0
    @State var elementsSize: [String: CGSize] = [:]
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        screenWidth = proxy.size.width
                    }
            }
            .frame(height: 0)
            
            grid
        }
    }
    
    var grid: some View {
        VStack(alignment: .leading, spacing: Const.Layout.smallPadding) {
            ForEach(makeGrid(), id: \.self) { rowElements in
                HStack(spacing: Const.Layout.smallPadding) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onAppear {
                                            elementsSize[element] = proxy.size
                                        }
                                }
                            )
                    }
                }
            }
        }
    }
    
    // функция разбивает элементы на строки
    // в зависимости от их ширины элемента
    private func makeGrid() -> [[String]] {
        var grid: [[String]] = [[]]
        var currentRow = 0
        var availableWidth = screenWidth
        
        for element in array {
            let elementSize = elementsSize[element, default: CGSize(width: screenWidth, height: 1)]
            if availableWidth - (elementSize.width + Const.Layout.smallPadding) >= 0 {
                grid[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                grid.append([element])
                availableWidth = screenWidth
            }
            availableWidth = availableWidth - (elementSize.width + Const.Layout.smallPadding)
        }
        return grid
    }
    
}
