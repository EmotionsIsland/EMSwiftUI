//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let cover: Image
    let title: String
    let group: String
    let rating: CGFloat
    let maxRating: Int = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            cover
                .resizedToFill(width: 100, height: 144)
                .clipShape(RoundedRectangle(cornerRadius: 4.0))
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.SFPro.semiboldNormal)
                    .lineLimit(1)
                RatingView(rating: rating, maxRating: maxRating)
                Text(group)
                    .font(.SFPro.lightSmall)
                    .foregroundStyle(.grayBase)
                    .lineLimit(1)
            }
            .frame(maxWidth: 100)
        }
    }
}
