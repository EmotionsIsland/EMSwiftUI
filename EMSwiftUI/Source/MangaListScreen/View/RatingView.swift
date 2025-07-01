//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: CGFloat
    let maxRating: Int = 5
    let starSize: CGFloat = 16
    let spacing: CGFloat = 2
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<maxRating, id: \.self) { index in
                ZStack {
                    Image("starIcon")
                        .resizable()
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(Color.gray.opacity(0.3))
                    if fill(for: index) > 0 {
                        Image("starIcon")
                            .resizable()
                            .frame(width: starSize, height: starSize)
                            .foregroundColor(.yellow)
                            .mask(
                                Rectangle()
                                    .size(width: starSize * fill(for: index), height: starSize)
                                    .alignmentGuide(.leading) { _ in 0 }
                            )
                    }
                }
            }
        }
    }

    private func fill(for index: Int) -> CGFloat {
        let value = rating - CGFloat(index)
        return min(max(value, 0), 1)
    }
}
