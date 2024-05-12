//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    let maxRating: Int
    
    let starHeight: CGFloat = 16
    private var starWidth: CGFloat {
        starHeight / 16 * 17
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Group {
                ForEach(Array(1...maxRating), id: \.self) { n in
                    Image(.starIcon)
                        .resizedToFill(width: starWidth, height: starHeight)
                        .foregroundStyle(.grayBase)
                        .overlay {
                            Rectangle()
                                .foregroundStyle(.yellow)
                                .frame(
                                    width: starWidthFilled(number: n),
                                    height: starHeight
                                )
                                .frame(
                                    width: starWidth,
                                    height: starHeight,
                                    alignment: .leading
                                )
                                .mask(
                                    Image(.starIcon)
                                        .resizedToFill(width: starWidth, height: starHeight)
                                )
                        }
                }
            }
        }
    }
}

private extension RatingView {
    func starWidthFilled(number starNumber: Int) -> CGFloat {
        switch starNumber {
        case 0...Int(rating):
            return starWidth
        case Int(rating)...Int(rating)+1:
            return starWidth * (rating - Double(Int(rating)))
        default:
            return 0
        }
    }
}
