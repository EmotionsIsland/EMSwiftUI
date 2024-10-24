//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

// MARK: - RatingView
struct RatingView: View {
    
    let rating: CGFloat
    let maxRating: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(.starIcon)
                    .resizable()
                    .foregroundStyle(.grayBase)
                    .frame(width: 16.5, height: 15.8)
                    .overlay {
                        Image(.starIcon)
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 16.5, height: 15.8)
                            .mask(Rectangle().size(width: widthForStar(at: index), height: 15.8))
                    }
            }
        }
    }
    
    private func widthForStar(at index: Int) -> CGFloat {
        let starRating = rating - CGFloat(index)
        
        if starRating >= 1 {
            return 16.5
        } else if starRating > 0 {
            return 16.5 * starRating
        } else {
            return 0
        }
    }
}

#Preview {
    RatingView(rating: 3.5, maxRating: 5)
}
