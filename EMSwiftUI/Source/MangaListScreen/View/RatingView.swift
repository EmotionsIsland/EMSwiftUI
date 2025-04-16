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
        HStack {
            ForEach(0..<maxRating, id: \.self) { index in
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Image(.starIcon)
                            .resizable()
                            .foregroundColor(.gray.opacity(0.2))

                        Image(.starIcon)
                            .resizable()
                            .foregroundColor(.yellow)
                            .mask(alignment: .leading) {
                                Rectangle()
                                    .frame(width: geometry.size.width * fillAmount(for: index))
                            }
                    }
                }
                .aspectRatio(1, contentMode: .fit)
            }
        }
    }

    private func fillAmount(for index: Int) -> CGFloat {
        let remaining = rating - CGFloat(index)
        return min(max(remaining, 0), 1)
    }
}
