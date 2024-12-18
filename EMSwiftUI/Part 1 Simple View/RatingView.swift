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
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { index in
                starView(for: CGFloat(index))
            }
        }
    }
    
    private func starView(for index: CGFloat) -> some View {
        ZStack {
            Image(asset: Asset.Icons.starIcon)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Asset.Colors.grayBase.swiftUIColor)
            
            if rating > index {
                Image(asset: Asset.Icons.starIcon)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.yellow)
                    .mask(
                        Rectangle()
                            .size(width: 20 * min(rating - index, 1), height: 20)
                            
                    )
            }
        }
    }
}

#Preview {
    RatingView(rating: 4, maxRating: 5)
}
