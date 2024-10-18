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
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                ZStack {
                    Image(.starIcon).resizedToFill(width: 17, height: 16)
                        .foregroundStyle(.grayBase)
                    
                    Image(.starIcon).resizedToFill(width: 17, height: 16)
                        .foregroundStyle(.yellow)
                        .mask {
                            Rectangle()
                                .size(width: fillMaskWidth(index: index), height: 16)
                        }
                }
            }
        }
        .frame(width: 100, height: 16)
    }
}

private extension RatingView {
    func fillMaskWidth(index: Int) -> CGFloat {
        let cgfIndex = CGFloat(index)
        let fillWidth = min(17, 17 * (rating - cgfIndex))
        return cgfIndex < rating ? fillWidth : 0
    }
}
