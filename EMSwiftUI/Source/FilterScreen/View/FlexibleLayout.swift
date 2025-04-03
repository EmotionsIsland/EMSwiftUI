//
//  FlexibleLayout.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 1.04.25.
//

import UIKit
import SwiftUICore

struct FlexibleLayout<Content: View>: View {
    @State private var screenWidth: CGFloat = 0
    @State private var gridHeight: CGFloat = 0
    @State var elementsSize: [String: CGSize] = [:]
    
    let array: [String]
    let content: (String) -> Content
    
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
}

private extension FlexibleLayout {
    var grid: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(makeGrid(), id: \.self) { rowElements in
                HStack(spacing: 4) {
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
    
    private func makeGrid() -> [[String]] {
        var grid: [[String]] = [[]]
        var currentRow = 0
        var availableWidth = screenWidth
        
        for element in array {
            let elementSize = elementsSize[element, default: CGSize(width: screenWidth, height: 1)]
            if availableWidth - (elementSize.width + 4) >= 0 {
                grid[currentRow].append(element)
            } else {
                currentRow += 1
                grid.append([element])
                availableWidth = screenWidth
            }
            availableWidth -= (elementSize.width + 20)
        }
        return grid
    }
}
