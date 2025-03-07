//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    var body: some View {
        VStack(spacing: 4) {
            Image(.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 144)
            VStack(alignment: .leading, spacing: 2) {
                Text("Long Manga name")
                    .font(FontFamily.SFPro.semibold.swiftUIFont(size: 16))
                    .lineLimit(1)
                    .foregroundStyle(.blackBase)
                VStack(alignment: .leading) {
                    RatingView(rating: 4.5, maxRating: 5)
                    Text("Genre, second genre")
                        .font(FontFamily.SFPro.light.swiftUIFont(size: 14))
                        .lineLimit(1)
                        .foregroundStyle(.grayBase)
                }
            }
            .frame(maxWidth: 100)
        }
        .onTapGesture {
            print("Open manga page")
        }
    }
}

#Preview {
    MangaSingleGridView()
}
