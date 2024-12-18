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
    
    private let starSize: CGFloat = 17
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                StarView(for: index)
            }
        }
    }
}

extension RatingView {
    
    @ViewBuilder
    private func StarView(for index: Int) -> some View {
        let currentRating = rating - Double(index)
        
        ZStack {
            Image(.starIcon)
                .resizedToFill(width: starSize, height: starSize)
                .foregroundColor(.grayBase)
            
            if currentRating > 0 {
                Image(.starIcon)
                    .resizedToFill(width: starSize, height: starSize)
                    .foregroundColor(.yellowStar)
                    .mask(
                        Rectangle()
                            .size(width: CGFloat(min(currentRating, 1)) * starSize, height: starSize)
                    )
            }
        }
    }

}
