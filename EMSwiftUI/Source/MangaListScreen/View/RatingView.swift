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
            ForEach(0..<maxRating, id: \.self) { index in
                ZStack {
                    Image("starIcon")
                        .resizable()
                        .foregroundStyle(Color.whiteText)
                        .frame(width: 17, height: 17)
                    if rating > CGFloat(index) {
                        Image("starIcon")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 17, height: 17)
                            .mask(
                                GeometryReader { geometry in
                                    let fillPercentage = min(rating - CGFloat(index), 1.0)
                                    Rectangle()
                                        .frame(width: geometry.size.width * fillPercentage,
                                               height: geometry.size.height)
                                        .position(x: (geometry.size.width * fillPercentage) / 2,
                                                  y: geometry.size.height / 2)
                                }
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    RatingView(rating: 3.4, maxRating: 5)
}
