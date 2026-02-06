//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    let maxRating: Int

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                let value = rating - Double(index)
                
                if value >= 1.0 {
                    Image("starIcon")
                        .resizable()
                        .renderingMode(.original)
                } else if value >= 0.5 {
                    Image("starIconHalf")
                        .resizable()
                        .renderingMode(.original)
                } else {
                    Image("starIcon")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.gray)
                        .opacity(0.3)
                }
            }
        }
    }
}
