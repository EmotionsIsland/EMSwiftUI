//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let title: String
    let coverURL: URL
    let genre: String
    
    var body: some View {
        VStack(spacing: 4) {
            AsyncImage(url: coverURL) { image in
                image.image?.resizable().scaledToFill().clipShape(RoundedRectangle(cornerRadius: 4))
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(FontFamily.SFPro.semibold.swiftUIFont(size: 16))
                    .lineLimit(1)
                    .foregroundStyle(.blackBase)
                VStack(alignment: .leading) {
                    RatingView(rating: CGFloat.random(in: 0...5), maxRating: 5)
                    Text(genre)
                        .font(FontFamily.SFPro.light.swiftUIFont(size: 14))
                        .lineLimit(1)
                        .foregroundStyle(.grayBase)
                }
            }
        }
        .onTapGesture {
            print("Open manga page")
        }
    }
}

#Preview {
    MangaSingleGridView(title: "Default title", coverURL: URL(string: "")!, genre: "Default genre")
}
