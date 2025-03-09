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
                ZStack(alignment: .leading) {
                    Image(.starIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.whiteText)
                    
                    Image(.starIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.yellow)
                        .mask(
                            GeometryReader { geo in
                                Rectangle()
                                    .frame(
                                        width: fillWidth(for: index, in: geo.size.width),
                                        alignment: .leading
                                    )
                            }
                        )
                }
            }
        }
    }

    private func fillWidth(for index: Int, in totalWidth: CGFloat) -> CGFloat {
            let remaining = rating - Double(index)
            return totalWidth * CGFloat(max(0, min(1, remaining)))
        }
}

#Preview {
    RatingView(rating: 3.2, maxRating: 5)
}
