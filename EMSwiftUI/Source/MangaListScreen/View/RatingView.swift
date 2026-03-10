//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    let maxRating: Int = 5

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image("starIcon")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.grayBase)
                    .overlay(
                        GeometryReader { geo in
                            Image("starIcon")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .mask(
                                    Rectangle()
                                        .size(width: geo.size.width * starFill(for: index),
                                              height: geo.size.height)
                                )
                        }
                    )
                    .frame(width: 16, height: 16)
            }
        }
        .frame(height: 16)
    }

    private func starFill(for index: Int) -> CGFloat {
        let value = rating - Double(index)
        if value >= 1 {
            return 1
        }
        if value > 0 {
            return CGFloat(value)
        }
        return 0
    }
}
