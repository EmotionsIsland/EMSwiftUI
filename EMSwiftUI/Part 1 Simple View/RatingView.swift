//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    var rating: Double

    var body: some View {
        let stars = HStack {
            ForEach(0..<Const.Other.maxRating, id: \.self) { _ in
                Asset.Icons.starIcon.swiftUIImage
                    .resizedToFit()
            }
        }

        stars.overlay(
            GeometryReader { proxy in
                let width = rating / CGFloat(Const.Other.maxRating) * proxy.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(Color.starYellow)
                }
            }
            .mask(stars)
        )
        .foregroundColor(Color.starGray)
    }
}
