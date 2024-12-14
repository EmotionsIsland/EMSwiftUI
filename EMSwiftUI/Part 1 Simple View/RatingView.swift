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
        HStack(spacing: 3) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(asset: Asset.Icons.starIcon)
                    .foregroundColor( index < Int(rating) ? .yellow : Asset.Colors.grayBase.swiftUIColor)
            }
            // MARK: -- Если мы хотим чтобы звезды были прибиты к левому углу, но так они не по центру
            //  Spacer()
        }
    }
}

#Preview {
    RatingView(rating: 4, maxRating: 5)
}
