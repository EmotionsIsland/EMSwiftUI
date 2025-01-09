//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: CGFloat

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<5) { star in
                    starType(for: star)
                        .foregroundColor(CGFloat(star) < rating ? .yellow : .grayBase)
                }
            }
            .frame(width: 100, alignment: .center)
        }
    }

    private func starType(for index: Int) -> Image {
        if CGFloat(index) < rating && CGFloat(index + 1) > rating {
            return Image(systemName: "star.leadinghalf.filled")
        } else {
            return Image(systemName: "star.fill")
        }
    }
}

#Preview {
    RatingView(rating: 3.4)
}
