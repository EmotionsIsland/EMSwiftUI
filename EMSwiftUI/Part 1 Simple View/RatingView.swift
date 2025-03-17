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
    
    private var ratingWidth: (Int) -> CGFloat {
        { index in
            max(0, min(1, rating - CGFloat(index))) * 17
        }
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                ZStack(alignment: .leading) {
                    Image(.starIcon)
                        .foregroundColor(.gray)
                        .frame(width:17 , height: 16)
                    
                    Image(.starIcon)
                        .foregroundColor(.yellow)
                        .mask(Rectangle()
                            .size(width: ratingWidth(index), height: 16))
                }
            }
        }
    }
}
