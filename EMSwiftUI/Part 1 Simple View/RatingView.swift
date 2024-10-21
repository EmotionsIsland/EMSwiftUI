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
    var starImage: Image = Image(.starIcon)
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...maxRating, id: \.self) { index in
                starImage
                    .resizable()
                    .frame(width: 17, height: 16)
                    .foregroundColor(.gray)
                    .overlay(
                        starImage
                            .resizable()
                            .foregroundColor(.yellow)
                            .mask(Rectangle().size(width: getWidthForRating(index), height: 16))
                    )
            }
        }
    }
}

#Preview {
    RatingView(rating: 3.5, maxRating: 5)
}

private extension RatingView {
    func getWidthForRating(_ index: Int) -> CGFloat {
        return CGFloat(min(rating - Double(index - 1), 1)) * 17
    }
}
