//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    public let rating: Double
    public var maxRating: Int = 5
    public var size: CGFloat = 20
    public var spacing: CGFloat = 4
    public var filledColor: Color = .yellow
    
    var body: some View {
        VStack {
            HStack(spacing: spacing) {
                ForEach(0..<maxRating, id: \.self) { index in
                    ZStack {
                        Image(systemName: "star.fill")
                            .resizedToFill(width: size, height: size)
                            .foregroundStyle(Color.gray.opacity(0.3))
                        if rating > CGFloat(index) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .renderingMode(.original)
                                .foregroundStyle(Color.yellow)
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
}
#Preview {
    RatingView(rating: 3.4)
}
