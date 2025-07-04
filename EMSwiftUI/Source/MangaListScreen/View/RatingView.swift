//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//
import SwiftUI

struct RatingView: View {
    let rating: Double
    let maxRating = 5
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(.zero..<maxRating, id: \.self) { index in
                Image(.starIcon)
                    .font(.body)
                    .overlay(
                        GeometryReader { proxy in
                            Rectangle()
                                .foregroundStyle(Color.yellow)
                                .frame(
                                    width: proxy.size.width * fillStar(at: index),
                                    height: proxy.size.height
                                )
                        }.mask(Image(.starIcon).font(.body))
                    )
            }
            .foregroundStyle(.grayBase)
        }
    }
    
    private func fillStar(at index: Int) -> CGFloat {
        return rating >= Double(index) + 1
        ? 1
        : (rating > Double(index) ? CGFloat(rating - Double(index)) : .zero)
    }
}
