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
            
            ForEach(0..<maxRating) { index in
                ZStack {
                    Image("starIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.grayBase)
                    
                    if index < Int(ceil(rating)) {
                        Image("starIcon")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.yellow)
                            .mask(
                                Rectangle()
                                    .size(width: getStarWidth(for: index), height: 16)
                            )
                    }
                }
            }
        }
    }
}

private extension RatingView {
    
    private func getStarWidth(for index: Int) -> CGFloat {
        if index < Int(rating) {
            return 16
        } else if index < Int(ceil(rating)) {
            return 16 * (rating - CGFloat(index))
        } else {
            return 0
        }
    }
}
