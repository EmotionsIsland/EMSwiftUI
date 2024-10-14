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
        VStack {
            HStack(spacing: 4) {
                ForEach(0..<maxRating, id: \.self) { index in
                    if index < Int(rating) {
                        Image("starIcon")
                            .resizable()
                            .frame(width: 17, height: 16)
                            .foregroundStyle(.yellow)
                    } else if index < Int(rating) + 1 && rating.truncatingRemainder(dividingBy: 1) >= 0.5 {
                        Image("halfStarIcon")
                            .resizable()
                            .frame(width: 17, height: 16)
                    } else {
                        Image("emptyStarIcon")
                            .resizable()
                            .frame(width: 17, height: 16)
                    }
                }
            }
        }
    }
}

#Preview {
    RatingView(rating: 3.5, maxRating: 5)
}
