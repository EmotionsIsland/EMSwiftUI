//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    
    let rating: CGFloat
    let maxRating: Int
    
    @State private var iconSize: CGFloat = 16
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                ZStack {
                    Image(.starIcon).resizedToFill(width: iconSize, height: iconSize)
                        .foregroundStyle(.grayBase)
                    
                    Image(.starIcon).resizedToFill(width: iconSize, height: iconSize)
                        .foregroundStyle(.yellow)
                        .mask {
                            Rectangle()
                                .size(width: fillMaskWidth(index: index), height: iconSize)
                        }
                }
            }
        }
        .frame(width: 100, height: iconSize)
    }
}

private extension RatingView {
    func fillMaskWidth(index: Int) -> CGFloat {
        let cgfIndex = CGFloat(index)
        let fillWidth = min(iconSize, iconSize * (rating - cgfIndex))
        return cgfIndex < rating ? fillWidth : 0
    }
}
