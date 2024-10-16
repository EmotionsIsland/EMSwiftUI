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
            ForEach(0..<Int(maxRating), id: \.self) { index in
                ZStack {
                    Image("starIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.grayBase)
                    
                    Image("starIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.yellow)
                        .mask(
                            Rectangle()
                                .size(width: starFillWidth(index: index), height: 16)
                        )
                }
            }
        }
    }
}

private extension RatingView {
    func starFillWidth(index: Int) -> CGFloat {
        let starIndex = CGFloat(index)
        if starIndex < rating {
            return min(16, 16 * (rating - starIndex))
        } else {
            return 0
        }
    }
}
