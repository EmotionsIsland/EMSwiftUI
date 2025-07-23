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
                let starValue = Double(index) + 1
                
                ZStack {
                    Image("starIcon")
                        .resizable()
                        .foregroundStyle(Color.whiteText)
                        .frame(width: 17, height: 17)
                    
                    if rating >= starValue {
                        Image("starIcon")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 17, height: 17)
                    } else if rating + 0.5 >= starValue {
                        Image("starIcon")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 17, height: 17)
                            .mask(
                                GeometryReader { geometry in
                                    Rectangle()
                                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                                        .position(x: geometry.size.width / 4, y: geometry.size.height / 2)
                                }
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    RatingView(rating: 3.5, maxRating: 5)
}
